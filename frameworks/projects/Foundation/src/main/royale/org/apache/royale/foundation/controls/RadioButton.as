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
	 * The change event is sent whenever the RadioButton is selected or
	 * de-selected.
	 */
	[Event("change","org.apache.royale.events.Event")]

	/**
	 * The RadioButton is an indicator and an label. RadioButton come in groups
	 * and only one RadioButton may be selected within the group. That is,
	 * selecting one will de-select another.
	 */
	public class RadioButton extends UIComponent implements ISelectable
	{
		public function RadioButton()
		{
			super();
			addClassName("RadioButton");

			RadioButton.addRadioToGroup(this);
		}


		//--------------------------------------------------------------------
		//
		// RadioButton Group Management
		//
		//--------------------------------------------------------------------

		private static var groupNames:Object = new Object();

		private static function addRadioToGroup(radioButton:RadioButton):void
		{
			if (!(groupNames.hasOwnProperty(radioButton.groupName))) {
				groupNames[radioButton.groupName] = [];
			}

			var list:Array = groupNames[radioButton.groupName] as Array;
			list.push(radioButton);
		}

		public static function removeRadioFromGroup(radioButton:RadioButton):void
		{
			if (!(groupNames.hasOwnProperty(radioButton.groupName))) {
				return;
			}

			var list:Array = groupNames[radioButton.groupName] as Array;
			for(var i:int=0; i < list.length; i++) {
				if (list[i] == radioButton) {
					list.splice(i,1);
					break;
				}
			}
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
		// groupName
		//---------------------------------------------

		private var _groupName:String = "radioGroup";

		public function get groupName():String
		{
			return _groupName;
		}

		public function set groupName(value:String):void
		{
			RadioButton.removeRadioFromGroup(this);

			_groupName = value;

			RadioButton.addRadioToGroup(this);

			COMPILE::JS {
				radioPart["name"] = value;
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

			// set the element's selection from the value given, true or false
			COMPILE::JS {
				radioPart.checked = value;
			}

			// only if this button's value is being set to true, go set
			// the others' values to false. Note that this function will
			// be called for them, but because value will be false this
			// loop will not be executed.
			if (value) {
				var list:Array = groupNames[groupName] as Array;
				for(var i:int=0; i < list.length; i++) {
					var radioButton:RadioButton = list[i] as RadioButton;
					if (radioButton != this) {
						radioButton.selected = false;
					}
				}
			}
		}

		//---------------------------------------------
		// controlElement
		//---------------------------------------------

		public function get controlElement():Object
		{
			COMPILE::JS {
				return radioPart;
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
				radioPart.value = String(newValue);
			}
		}


		//--------------------------------------------------------------------
		//
		// UIComponent Overrides
		//
		//--------------------------------------------------------------------

		static private var buttonCount:int = 0;

		COMPILE::JS
		private var radioPart:HTMLInputElement;

		COMPILE::JS
		private var labelPart:WrappedHTMLElement;

		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 * @royaleignorecoercion HTMLInputElement
		 */
		COMPILE::JS
		override public function createElement():WrappedHTMLElement
		{
			var radio:WrappedHTMLElement = document.createElement('div') as WrappedHTMLElement;
			this.element = radio;

			radioPart = document.createElement('input') as HTMLInputElement;
			radioPart.id = "_radio_"+String(buttonCount++);
			radioPart.className = "RadioButtonIcon";
			radioPart.type = "radio";
			radioPart.name = groupName;

			labelPart = document.createElement('label') as WrappedHTMLElement;
			labelPart.className = "RadioButtonLabel";
			labelPart["htmlFor"] = radioPart.id;

			element.appendChild(radioPart);
			element.appendChild(labelPart);

			return element;
		}
	}
}
