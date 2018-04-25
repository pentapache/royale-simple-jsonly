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
package org.apache.royale.simple.controls
{
	import org.apache.royale.events.Event;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.core.IPopUpHost;
	import org.apache.royale.simple.core.UIComponent;

	[Event("change", "org.apache.royale.events.Event")]

	/**
	 * The DateField component presents an input area and a button. Use the
	 * input area to enter a date and use the button to pop-up a DateChooser.
	 * Note: an INPUT element of type date or datetime is not supported on all
	 * browsers yet, so this class does things more manually.
	 */
	public class DateField extends UIComponent
	{
		public function DateField()
		{
			super();
			setClassName("DateField");

			inputField = new TextInput();
			inputField.addClassName("dateField_input");
			addElement(inputField, false);

			popupButton = new Button();
			popupButton.addClassName("dateField_button");
			popupButton.label = "▽";
			popupButton.addEventListener("click", clickHandler);
			addElement(popupButton, false);

			selectedDate = new Date();
		}

		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		private var inputField: TextInput;
		private var popupButton: Button;
		private var dateChooser: DateChooser;

		//---------------------------------------------
		// selectedDate
		//---------------------------------------------

		private var _selectedDate:Date;

		public function get selectedDate():Date
		{
			return _selectedDate;
		}

		public function set selectedDate(value:Date):void
		{
			_selectedDate = value;

			inputField.text = formatDate(selectedDate);

			dispatchEvent(new Event("change"));
		}


		//--------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------

		protected function formatDate(date:Date):String
		{
			COMPILE::JS {
				var options:Object = {year:'numeric', month:'numeric', day:'numeric'};
				return selectedDate.toLocaleDateString('en-US',options);
			}
			COMPILE::SWF {
				return date.toString();
			}
		}


		//--------------------------------------------------------------------
		//
		// Event handling
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// clickHandler - popUp button
		//---------------------------------------------

		private function clickHandler(event:MouseEvent):void
		{
			var host:IPopUpHost = findPopUpHost();
			if (dateChooser == null) {
				dateChooser = new DateChooser();
				dateChooser.addClassName("dateField_chooser");
			dateChooser.addEventListener("change", datePicked);
			}
			dateChooser.selectedDate = selectedDate;
			host.popUpAt(dateChooser, event.clientX, event.clientY);
		}

		//---------------------------------------------
		// datePicked - DateChooser popUp
		//---------------------------------------------

		private function datePicked(event:Event):void
		{
			selectedDate = dateChooser.selectedDate;

			var host:IPopUpHost = findPopUpHost();
			host.popDown(dateChooser);

			dispatchEvent(new Event("change"));
		}
	}
}
