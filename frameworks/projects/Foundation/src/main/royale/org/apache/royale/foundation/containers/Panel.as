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
package org.apache.royale.foundation.containers
{
	import org.apache.royale.foundation.core.UIComponent;
	import org.apache.royale.foundation.controls.ControlBar;
	import org.apache.royale.foundation.controls.TitleBar;
	import org.apache.royale.foundation.containers.layouts.FlexLayout;

	/**
	 * Overrides the superclass's default property.
	 */
	[DefaultProperty("contentArea")]

	/**
	 * A Panel is a specialized Container that places a TitleBar
	 * across its top and a single child below, filling out the rest
	 * of the Panel's space.
	 *
	 * Use the Panel's leftItems and rightItems properties to add controls
	 * to those areas of the TitleBar.
	 *
	 * A Panel can also have a ControlBar appear at the bottom, below
	 * the content area using the controlBar property.
	 */
	public class Panel extends Container
	{
		public function Panel()
		{
			super();
			setClassName("Panel");

			var flex:FlexLayout = layout as FlexLayout;
			flex.direction = "vertical";
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// contentArea (default property)
		//---------------------------------------------

		private var _contentArea:UIComponent;

		public function get contentArea():UIComponent
		{
			return _contentArea;
		}

		public function set contentArea(value:UIComponent):void
		{
			_contentArea = value;
			_contentArea.setClassName("panel_contentArea");
		}

		//---------------------------------------------
		// titleBar
		//---------------------------------------------

		private var _titleBar:TitleBar;

		//---------------------------------------------
		// title
		//---------------------------------------------

		private var _title:String;

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

		//---------------------------------------------
		// leftItems
		//---------------------------------------------

		private var _leftItems:Array;

		public function get leftItems():Array
		{
			return _leftItems;
		}

		public function set leftItems(value:Array):void
		{
			_leftItems = value;
		}

		//---------------------------------------------
		// rightItems
		//---------------------------------------------

		private var _rightItems:Array;

		public function get rightItems():Array
		{
			return _rightItems;
		}

		public function set rightItems(value:Array):void
		{
			_rightItems = value;
		}

		//---------------------------------------------
		// controlBar
		//---------------------------------------------

		private var _controlBar:ControlBar;

		private var _controlBarItems:Array;

		public function get controlBar():Array
		{
			return _controlBarItems;
		}

		public function set controlBar(value:Array):void
		{
			_controlBarItems = value;
		}


		//--------------------------------------------------------------------
		//
		// UIComponent Overrides
		//
		//--------------------------------------------------------------------

		override public function addedToParent():void
		{
			super.addedToParent();

			_titleBar = new TitleBar();
			_titleBar.addClassName("panel_titleBar");
			_titleBar.title = title;
			_titleBar.leftItems = leftItems;
			_titleBar.rightItems = rightItems;
			addElement(_titleBar);

			addElement(_contentArea);

			if (_controlBarItems) {
				_controlBar = new ControlBar();
				_controlBar.controls = _controlBarItems;
				addElement(_controlBar);
			}
		}
	}
}
