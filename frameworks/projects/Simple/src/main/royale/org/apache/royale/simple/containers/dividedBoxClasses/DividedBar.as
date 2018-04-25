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
package org.apache.royale.simple.containers.dividedBoxClasses
{
	import org.apache.royale.events.Event;
	import org.apache.royale.core.IChild;
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.simple.core.UIComponent;
	import org.apache.royale.simple.svg.Path;
	COMPILE::JS {
		import org.apache.royale.events.BrowserEvent;
	}

	/**
	 * The DividedBar is the base class for the separator/resizing control bars
	 * between children of a DividedBox.
	 *
	 * TODO: place mouse event handling into a controller bead.
	 */
	public class DividedBar extends UIComponent
	{
		public function DividedBar()
		{
			super();

			_gripper = new Path();
			addElement(_gripper, false);

			COMPILE::JS {
				element.addEventListener("mousedown", handleDown);
			}
		}

		override public function addedToParent():void
		{
			super.addedToParent();
			redraw();
		}

		private var _gripper:Path;

		protected function get gripper():Path
		{
			return _gripper;
		}

		protected function redraw():void
		{
		}

		private var _beforeChild:IChild;

		public function get beforeChild():IChild
		{
			return _beforeChild;
		}

		public function set beforeChild(value:IChild):void
		{
			_beforeChild = value;
		}

		private var _afterChild:IChild;

		public function get afterChild():IChild
		{
			return _afterChild;
		}

		public function set afterChild(value:IChild):void
		{
			_afterChild = value;
		}

		protected function adjustChildBefore(newWidth:Number, newHeight:Number):void
		{
			// implement in subclass
		}

		protected function adjustChildAfter(newWidth:Number, newHeight:Number):void
		{
			// implement in subclass
		}

		private var originX:Number;
		private var originY:Number;

		private var deltaX:Number;
		private var deltaY:Number;

		private var childBeforeHeight:Number;
		private var childBeforeWidth:Number;
		private var childAfterHeight:Number;
		private var childAfterWidth:Number;

		/**
		 * @royaleignorecoercion org.apache.royale.core.IUIBase;
		 */
		COMPILE::JS
		private function handleDown(event:BrowserEvent):void
		{
			var host:IUIBase = findPopUpHost() as IUIBase;
			host.element.addEventListener("mousemove", handleMove);
			host.element.addEventListener("mouseup", handleUp);

			originX = event.clientX;
			originY = event.clientY;

			childBeforeHeight = (beforeChild as IUIBase).height;
			childBeforeWidth = (beforeChild as IUIBase).width;
			childAfterHeight = (afterChild as IUIBase).height;
			childAfterWidth = (afterChild as IUIBase).width;
		}

		/**
		 * @royaleignorecoercion org.apache.royale.core.IUIBase;
		 */
		COMPILE::JS
		private function handleMove(event:BrowserEvent):void
		{
			deltaX = originX - event.clientX;
			deltaY = originY - event.clientY;

			adjustChildBefore(childBeforeWidth - deltaX, childBeforeHeight - deltaY);
			adjustChildAfter(childAfterWidth + deltaX, childAfterHeight + deltaY);
		}

		COMPILE::JS
		private function handleUp(event:BrowserEvent):void
		{
			var host:IUIBase = findPopUpHost() as IUIBase;
			host.element.removeEventListener("mousemove", handleMove);
			host.element.removeEventListener("mouseup", handleUp);

			deltaX = originX - event.clientX;
			deltaY = originY - event.clientY;

			adjustChildBefore(childBeforeWidth - deltaX, childBeforeHeight - deltaY);
			adjustChildAfter(childAfterWidth + deltaX, childAfterHeight + deltaY);
		}
	}
}
