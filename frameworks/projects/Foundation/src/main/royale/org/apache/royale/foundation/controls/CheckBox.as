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
package org.apache.royale.foundation.controls
{
	import org.apache.royale.core.ISelectable;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	import org.apache.royale.foundation.core.UIComponent;

	/**
	 * The change event is dispatched when the CheckBox changes state. Use
	 * the selected property to determine the current state.
	 */
	[Event("change","org.apache.royale.events.Event")]

	/**
	 * The CheckBox presents a control with a label and an indicator (usually a
	 * small box with a checkmark) when selected.
	 */
	public class CheckBox extends UIComponent implements ISelectable
	{
		public function CheckBox()
		{
			super();
			addClassName("CheckBox");
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// label
		//---------------------------------------------

		private var _label:String;

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;

			COMPILE::JS {
				labelPart.innerHTML = value;
			}
		}

		//---------------------------------------------
		// selected
		//---------------------------------------------

		private var _selected:Boolean = false;

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;

			COMPILE::JS {
				checkPart["checked"] = value;
			}
		}

		//---------------------------------------------
		// controlElement
		//---------------------------------------------

		public function get controlElement():Object
		{
			COMPILE::JS {
				return checkPart;
			}
			COMPILE::SWF {
				return element;
			}
		}

		//---------------------------------------------
		// value
		//---------------------------------------------

		private var _value:Object;

		public function get value():Object
		{
			return _value;
		}

		public function set value(newValue:Object):void
		{
			_value = newValue;

			COMPILE::JS {
				checkPart["value"] = newValue;
			}
		}


		//--------------------------------------------------------------------
		//
		// UIComponent Overrides
		//
		//--------------------------------------------------------------------

		static private var buttonCount:int = 0;

		COMPILE::JS
		private var checkPart:WrappedHTMLElement;

		COMPILE::JS
		private var labelPart:WrappedHTMLElement;

		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 */
		COMPILE::JS
		override public function createElement():WrappedHTMLElement
		{
			var input:WrappedHTMLElement = document.createElement('div') as WrappedHTMLElement;
			this.element = input;

			checkPart = document.createElement('input') as WrappedHTMLElement;
			checkPart.id = "_checkbox_"+String(buttonCount++);
			checkPart.className = "CheckBoxIcon";
			checkPart["type"] = "checkbox";

			labelPart = document.createElement('label') as WrappedHTMLElement;
			labelPart.className = "CheckBoxLabel";
			labelPart["htmlFor"] = checkPart.id;

			element.appendChild(checkPart);
			element.appendChild(labelPart);

			return element;
		}
	}
}
