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
	 * HorizontalLayout makes the children of a Container line up side-by-side. You
	 * can also do this yourself via CSS. For example, you could give all the children
	 * a float:left or float:right and accomplish nearly the same thing.
	 */
	public class HorizontalLayout implements IBeadLayout
	{
		public function HorizontalLayout()
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

		private var _layoutClassName:String = "HorizontalLayout";

		public function get layoutClassName():String
		{
			return _layoutClassName;
		}

		public function set layoutClassName(value:String):void
		{
			if (strand) (strand as IUIBase).removeClassName(layoutClassName);
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
					var targetStyle:String = "inline-block";

					if (displayStyle.includes("table")) targetStyle = "inline-table";
					else if (displayStyle.includes("flex")) targetStyle = "inline-flex";
					else if (child is IList) targetStyle = "inline-table";

					child.element.style.display = targetStyle;
				}
			}

			return true;
		}
	}
}
