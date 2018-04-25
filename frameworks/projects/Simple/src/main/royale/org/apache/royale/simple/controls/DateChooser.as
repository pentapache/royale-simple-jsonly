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
	import org.apache.royale.simple.core.UIComponent;
	import org.apache.royale.simple.containers.Container;
	import org.apache.royale.simple.containers.FlexBox;
	import org.apache.royale.simple.controls.Button;
	import org.apache.royale.simple.controls.Label;
	import org.apache.royale.simple.controls.TextBlock;
	import org.apache.royale.simple.controls.dateClasses.DateChooserItemRenderer;

	/**
	 * The change event is dispatched whenever the selectedDate changes.
	 */
	[Event("change", "org.apache.royale.events.Event")]

	/**
	 * The currentMonthChanged event is dispatched if the current month being
	 * displayed changes. This may be dispatched in conjunction with the change
	 * event.
	 */
	[Event("currentMonthChanged", "org.apache.royale.events.Event")]

	/**
	 * The currentYearChanged event is dispatched if the current year being
	 * displayed changes. This may be dispatched in conjunction with the
	 * currentMonthChanged and changed events.
	 */
	[Event("currentYearChanged", "org.apache.royale.events.Event")]

	/**
	 * The DateChooser class presents a one-month calendar with selectable dates.
	 */
	public class DateChooser extends UIComponent
	{
		public function DateChooser()
		{
			super();
			addClassName("DateChooser");

			headerArea = new FlexBox();
			headerArea.setClassName("headerArea");
			addElement(headerArea);

			weekdayArea = new FlexBox();
			weekdayArea.setClassName("weekdayArea");
			addElement(weekdayArea, false);

			_contentArea = new Container();
			contentArea.setClassName("contentArea");
			addElement(contentArea);

			// default to "today"
			selectedDate = new Date();
		}

		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// currentMonth
		//---------------------------------------------

		private var _currentMonth:uint;

		public function get currentMonth():uint
		{
			return _currentMonth;
		}

		public function set currentMonth(value:uint):void
		{
			if (value != _currentMonth) {
				_currentMonth = value;
				generateCalendar();
			}
		}

		//---------------------------------------------
		// currentYear
		//---------------------------------------------

		private var _currentYear:uint;

		public function get currentYear():uint
		{
			return _currentYear;
		}

		public function set currentYear(value:uint):void
		{
			if (value != _currentYear) {
				_currentYear = value;
				generateCalendar();
			}
		}

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
			// de-select the previously selected date
			if (_selectedDate) {
				var oldRenderer:DateChooserItemRenderer = findItemRenderer(_selectedDate);
				if (oldRenderer) oldRenderer.removeClassName("dateSelect");
			}

			if (_selectedDate == null) {
				_selectedDate = value;
				_currentMonth = _selectedDate.getMonth();
				_currentYear = _selectedDate.getFullYear();
				generateCalendar();
			}
			else if (value.getFullYear() != _selectedDate.getFullYear() ||
			    value.getMonth() != _selectedDate.getMonth() ||
			    value.getDate() != _selectedDate.getDate())
			{
				_selectedDate = value;
				_currentMonth = _selectedDate.getMonth();
				_currentYear = _selectedDate.getFullYear();
				generateCalendar();

				var newRenderer:DateChooserItemRenderer = findItemRenderer(_selectedDate);
				newRenderer.addClassName("dateSelect");
			}
		}

		//---------------------------------------------
		// monthNames
		//---------------------------------------------

		private var _monthNames:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

		public function get monthNames():Array
		{
			return _monthNames;
		}

		public function set monthNames(value:Array):void
		{
			if (value != null && value.length == 12) {
				_monthNames = value;
				generateCalendar();
			}
		}

		//---------------------------------------------
		// weekdayNames
		//---------------------------------------------

		private var _weekdayNames:Array = ["S", "M", "T", "W", "T", "F", "S"];

		public function get weekdayNames():Array
		{
			return _weekdayNames;
		}

		public function set weekdayNames(value:Array):void
		{
			if (value != null && value.length == 7) {
				_weekdayNames = value;
				generateCalendar();
			}
		}

		//---------------------------------------------
		// prevMonthButton
		//---------------------------------------------

		private var _prevMonthButton:Button;

		public function get prevMonthButton():Button
		{
			return _prevMonthButton;
		}

		//---------------------------------------------
		// nextMonthButton
		//---------------------------------------------

		private var _nextMonthButton:Button;

		public function get nextMonthButton():Button
		{
			return _nextMonthButton;
		}

		//---------------------------------------------
		// contentArea
		//---------------------------------------------

		private var _contentArea:Container;

		public function get contentArea():Container
		{
			return _contentArea;
		}

		//--------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------

		private var headerArea:FlexBox;
		private var weekdayArea:FlexBox;

		private var titleLabel:TextBlock;

		// holds all the DateChooserItemRenderer instances so they can be reused.
		// not sure if this is faster than removing them all and re-generating them.
		private var days:Array;

		//---------------------------------------------
		// displayMonth
		//---------------------------------------------

		public function displayMonth(month:int, year:int):void
		{
			_currentMonth = month;
			_currentYear = year;

			generateCalendar();
		}

		//---------------------------------------------
		// generateHeader
		//---------------------------------------------

		protected function generateHeader():void
		{
			if (_prevMonthButton == null) {
				_prevMonthButton = new Button();
				_prevMonthButton.label = "◀︎";
				headerArea.addElement(_prevMonthButton,false);
			}

			if (titleLabel == null) {
				titleLabel = new TextBlock();
				headerArea.addElement(titleLabel,false);
			}
			titleLabel.text = monthNames[currentMonth]+ " "+String(currentYear);

			if (_nextMonthButton == null) {
				_nextMonthButton = new Button();
				_nextMonthButton.label = "▶︎";
				headerArea.addElement(_nextMonthButton,false);
			}
		}

		//---------------------------------------------
		// generateWeekdays
		//---------------------------------------------

		protected function generateWeekdays():void
		{
			if (weekdayArea.numElements == 0) {
				for (var i:int=0; i < 7; i++) {
					var wday:TextBlock = new TextBlock();
					wday.setClassName("weekday");
					weekdayArea.addElement(wday);
				}
			}

			for (i=0; i < 7; i++) {
				wday = weekdayArea.getElementAt(i) as TextBlock;
				wday.text = weekdayNames[i];
			}
		}

		//---------------------------------------------
		// generateCalendar
		//---------------------------------------------

		protected function generateCalendar():void
		{
			generateHeader();
			generateWeekdays();

			var dayOfMonth:DateChooserItemRenderer;

			if (days == null) {
				days = [];
				for (var i:int=0; i < 42; i++)
				{
					dayOfMonth = new DateChooserItemRenderer();
					dayOfMonth.setClassName("date");
					contentArea.addElement(dayOfMonth, false);
					days.push(dayOfMonth);
				}
			}

			var today:Date = new Date();
            var firstDay:Date = new Date(currentYear,currentMonth,1);
            var firstDayOfWeek:int = firstDay.getDay();

            // blank the beginning days of the month
            for (i=0; i < firstDayOfWeek; i++) {
            	days[i].text = "";
            	days[i].date = null;
            	days[i].removeClassName("dateSelect");
            }

            var dayNumber:int = 1;
            var numDays:Number = numberOfDaysInMonth(currentYear, currentMonth);

            while(dayNumber <= numDays) {
                var day:Date = new Date(currentYear, currentMonth, dayNumber++);
                days[i].text = String(day.getDate());
                days[i].date = day;

                if (isSameDay(today, day)) days[i].addClassName("today");
                else days[i].removeClassName("today");

				if (isSameDay(selectedDate, day)) days[i].addClassName("dateSelect");
                else days[i].removeClassName("dateSelect");

                i++;
            }

			// blank the remaining days of the month
            for (; i < days.length; i++) {
            	days[i].text = "";
            	days[i].date = null;
            	days[i].removeClassName("dateSelect");
            }
		}

		private function isSameDay(today:Date, test:Date):Boolean
		{
			if (today == null) return false;

			return (today.getFullYear() == test.getFullYear()) &&
			       (today.getMonth() == test.getMonth()) &&
			       (today.getDate() == test.getDate());
		}

		//---------------------------------------------
		// numberOfDaysInMonth
		//---------------------------------------------

        private function numberOfDaysInMonth(year:Number, month:Number):Number
        {
            var n:int;

            if (month == 1) // Feb
            {
                if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) // leap year
                    n = 29;
                else
                    n = 28;
            }

            else if (month == 3 || month == 5 || month == 8 || month == 10)
                n = 30;

            else
                n = 31;

            return n;
        }

		//---------------------------------------------
		// findItemRenderer
		//---------------------------------------------

        private function findItemRenderer(date:Date):DateChooserItemRenderer
        {
        	for (var i:int=0; i < days.length; i++) {
        		var dayOfMonth:DateChooserItemRenderer = days[i] as DateChooserItemRenderer;
        		if (dayOfMonth.date == null) continue;
        		if ((date.getFullYear() == dayOfMonth.date.getFullYear()) &&
        		    (date.getMonth() == dayOfMonth.date.getMonth()) &&
        		    (date.getDate() == dayOfMonth.date.getDate())) return dayOfMonth;
        	}
        	return null;
        }
	}
}
