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
	 * The FlexLayout makes immediate children of a Container expand or contract
	 * as things change in the Container. This layout will set the display style
	 * on the Container to display:flex and set the flex-flow according to
	 * the value of the direction property (default is row - horizontal layout).
	 * The children of the Container should have their flex styles set via CSS; this
	 * layout does not touch them.
	 *
	 * Because of the flexible nature of Flexbox, each child should have its own
	 * flex-grow or flex-shrink or other flex-related styles set.
	 */
	public class FlexLayout implements IBeadLayout
	{
		public function FlexLayout()
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
		// direction
		//---------------------------------------------

		private var _direction:String = "horizontal";

		public function get direction():String
		{
			return _direction;
		}

		public function set direction(value:String):void
		{
			_direction = value;
			if (strand) performLayout(null);
		}

		//---------------------------------------------
		// layoutClassName
		//---------------------------------------------

		private var _layoutClassName:String = "FlexLayout";

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

			COMPILE::JS {
				component.element.style.display = "flex";
				component.element.style["flex-flow"] = (direction == "horizontal") ? "row" : "column";
			}

			return true;
		}
	}
}
