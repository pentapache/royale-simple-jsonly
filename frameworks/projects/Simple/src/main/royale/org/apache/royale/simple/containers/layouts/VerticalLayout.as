////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.royale.simple.containers.layouts
{
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.core.IBeadLayout;
	import org.apache.royale.core.IChild;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.simple.core.IList;

	/**
	 * VerticalLayout makes all of the children within a Container stack one on top
	 * of another. You can also use CSS to accomplish the same thing.
	 */
	public class VerticalLayout implements IBeadLayout
	{
		public function VerticalLayout()
		{
		}

		//---------------------------------------------
		// strand
		//---------------------------------------------

		private var _strand:IStrand;

		public function get strand():IStrand
		{
			return _strand;
		}

		public function set strand(value:IStrand):void
		{
			_strand = value;

			(_strand as IEventDispatcher).addEventListener("componentAdded", performLayout);
			(_strand as IEventDispatcher).addEventListener("childrenAdded", performLayout);
		}

		//---------------------------------------------
		// layoutClassName
		//---------------------------------------------

		private var _layoutClassName:String = "VerticalLayout";

		public function get layoutClassName():String
		{
			return _layoutClassName;
		}

		public function set layoutClassName(value:String):void
		{
			(strand as IUIBase).removeClassName(layoutClassName);
			_layoutClassName = value;
			if (strand) performLayout(null);
		}

		//---------------------------------------------
		// layoutChildClassName
		//---------------------------------------------

		private var _layoutChildClassName:String = null;

		/**
		 * The layoutChildClassName (defaults to null) can be added to each
		 * child of the layout for extra styling.
		 */
		public function get layoutChildClassName():String
		{
			return _layoutChildClassName;
		}

		public function set layoutChildClassName(value:String):void
		{
			(strand as IUIBase).removeClassName(layoutChildClassName);
			_layoutChildClassName = value;
			if (strand) performLayout(null);
		}

		//---------------------------------------------
		// layout
		//---------------------------------------------

		protected function performLayout(event:Event):void
		{
			layout();
		}

		public function layout():Boolean
		{
			var component:IUIBase = strand as IUIBase;
			var numElements:Number = component.numElements;

			component.addClassName(layoutClassName);

			for(var i:int=0; i < numElements; i++) {
				var child:IUIBase = component.getElementAt(i) as IUIBase;
				if (layoutChildClassName)
					child.addClassName(layoutChildClassName);
				COMPILE::JS {
					var displayStyle:String = child.element.style.display;
					var targetStyle:String = "block";

					if (displayStyle.includes("table")) targetStyle = "table";
					else if (displayStyle.includes("flex")) targetStyle = "flex";
					else if (child is IList) targetStyle = "table";

					child.element.style.display = targetStyle;
				}
			}

			return true;
		}
	}
}
