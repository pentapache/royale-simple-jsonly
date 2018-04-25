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
package org.apache.royale.simple.controls.controllers
{
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.EventDispatcher;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.simple.core.UIComponent;
	import org.apache.royale.simple.controls.Button;
	import org.apache.royale.simple.controls.DateChooser;
	import org.apache.royale.simple.controls.dateClasses.DateChooserItemRenderer;

	COMPILE::JS {
		import org.apache.royale.events.BrowserEvent;
	}

	/**
	 * The DateChooserMouseController watches for mouse clicks within the DateChooser
	 * and modifies the DateChooser as needed before dispatching events.
	 */
	public class DateChooserMouseController extends EventDispatcher implements IBeadController
	{
		public function DateChooserMouseController()
		{
			super();
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

			COMPILE::JS {
				var prevMonthButton:EventDispatcher = (strand as DateChooser).prevMonthButton;
				prevMonthButton.addEventListener("click", showPrevMonth);

				var nextMonthButton:EventDispatcher = (strand as DateChooser).nextMonthButton;
				nextMonthButton.addEventListener("click", showNextMonth);

				var contentArea:UIComponent = (strand as DateChooser).contentArea;
				contentArea.element.addEventListener("click", selectNewDate);
			}
		}

		//---------------------------------------------
		// showPrevMonth
		//---------------------------------------------

		private function showPrevMonth(event:MouseEvent):void
		{
			var chooser:DateChooser = strand as DateChooser;
			var dispatchYearChange:Boolean = false;

			var prevMonth:int = chooser.currentMonth - 1;
			var prevYear:int = chooser.currentYear;
			if (prevMonth < 0) {
				prevMonth = 11;
				prevYear -= 1;
				dispatchYearChange = true;
			}
			chooser.displayMonth(prevMonth, prevYear);

			// dispatch year year change, month change in that order.
			if (dispatchYearChange)
				(strand as EventDispatcher).dispatchEvent(new Event("currentYearChanged"));

			(strand as EventDispatcher).dispatchEvent(new Event("currentMonthChanged"));
		}

		//---------------------------------------------
		// showNextMonth
		//---------------------------------------------

		private function showNextMonth(event:MouseEvent):void
		{
			var chooser:DateChooser = strand as DateChooser;
			var dispatchYearChange:Boolean = false;

			var nextMonth:int = chooser.currentMonth + 1;
			var nextYear:int = chooser.currentYear;
			if (nextMonth > 11) {
				nextMonth = 0;
				nextYear += 1;
				dispatchYearChange = true;
			}
			chooser.displayMonth(nextMonth, nextYear);

			// dispatch year year change, month change in that order.
			if (dispatchYearChange)
				(strand as EventDispatcher).dispatchEvent(new Event("currentYearChanged"));

			(strand as EventDispatcher).dispatchEvent(new Event("currentMonthChanged"));
		}

		//---------------------------------------------
		// selectNewDate
		//---------------------------------------------

		COMPILE::JS
		private function selectNewDate(event:BrowserEvent):void
		{
			var dayOfMonth:DateChooserItemRenderer = event.target.royale_wrapper as DateChooserItemRenderer;
			if (dayOfMonth) {
				(strand as DateChooser).selectedDate = dayOfMonth.date;
				(strand as EventDispatcher).dispatchEvent(new Event("change"));
			}
		}

		private function handleRemoval(event:Event):void
		{
			trace("My strand has been removed!");
		}
	}
}
