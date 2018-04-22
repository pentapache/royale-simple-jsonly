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
////////////////////////////////////////////////////////////////////////////////'
package org.apache.royale.foundation.controls
{
	import org.apache.royale.core.IChild;
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.events.BrowserEvent;
	}
	import org.apache.royale.foundation.core.UIComponent;
	import org.apache.royale.foundation.containers.Container;
	import org.apache.royale.foundation.controls.Label;

	/**
	 * A TitleBar provides a horizontal banner with a centered
	 * text title and optional controls on the left and right sides.
	 */
	public class TitleBar extends UIComponent
	{
		public function TitleBar()
		{
			super();
			addClassName("TitleBar");
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// title
		//---------------------------------------------

		private var _title:String;
		private var _titleLabel:Label;

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


		//--------------------------------------------------------------------
		//
		// UIComponent overrides
		//
		//--------------------------------------------------------------------

		override public function addedToParent():void
		{
			super.addedToParent();

			COMPILE::JS {

				var i:int;
				var item:UIComponent;

				if (leftItems) {
					for(i=0; i < leftItems.length; i++) {
						item = leftItems[i] as UIComponent;
						item.addClassName("titleBar_leftItem");
						addElement(item);
					}
				}

				if (title) {
					_titleLabel = new Label();
					_titleLabel.setClassName("titleBar_title");
					_titleLabel.text = title;
					addElement(_titleLabel);
				}

				if (rightItems) {
					for(i=0; i < rightItems.length; i++) {
						item = rightItems[i] as UIComponent;
						item.addClassName("titleBar_rightItem");
						addElement(item);
					}
				}
			}
		}
	}
}
