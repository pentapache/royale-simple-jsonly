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
package controllers
{
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.foundation.core.IDataProvider;
	import org.apache.royale.foundation.core.IList;
	import org.apache.royale.foundation.controls.SelectList;
	import org.apache.royale.foundation.controls.TextInput;
	import WeatherExample;

	/**
	 * The CityListController is responsible for managing the SelectList
	 * that displays the list of cities and to transfer that selection to
	 * the input field.
	 */
	public class CityListController implements IBead, IDataProvider
	{
		public function CityListController()
		{
		}

		// ---------------------------------------------------
		// selectedCity
		// ---------------------------------------------------

		private var _selectedCity:String;

		public function get selectedCity():String
		{
			return _selectedCity;
		}

		// ---------------------------------------------------
		// strand
		// ---------------------------------------------------

		private var _strand:IStrand;

		/**
		 * The strand is the component which in this example is the WeatherExample
		 * app itself. The strand setter sets up a listener to wait for the app (aka
		 * strand) to notify that it is set up.
		 */
		public function get strand():IStrand
		{
			return _strand;
		}
		public function set strand(value:IStrand):void
		{
			_strand = value;

			IEventDispatcher(strand).addEventListener("applicationComplete", handleAppComplete);
		}

		// ---------------------------------------------------
		// setup
		// ---------------------------------------------------

		private var inputField:TextInput;
		private var selectField:SelectList;

		/**
		 * When the app is ready, pull the SelectList and TextInput controls from the
		 * app (aka, strand) and set this class up as the IDataProvider for the SelectList.
		 */
		private function handleAppComplete(event:Event):void
		{
			inputField = WeatherExample(_strand).cityTI;

			selectField = WeatherExample(_strand).cityList;
			selectField.dataProvider = this;
			selectField.addEventListener("change", handleListChange);
		}

		/**
		 * When the SelectList changes this function transfers the selection to the
		 * input field.
		 */
		private function handleListChange(event:Event):void
		{
			if (selectField.selectedIndex == 0) {
				inputField.text = "";
			} else {
				inputField.text = _cities[selectField.selectedIndex];
			}

			_selectedCity = inputField.text;
		}

		// ---------------------------------------------------
		// Pre-defined city list
		// ---------------------------------------------------

		private var _cities:Array = ["select one",
			"Amsterdam", "Bogota", "Boston", "Canberra", "Lima", "London",
			"Madrid", "Miami", "New York", "Paris", "Prague", "Rome", "Sydney",
			"Tel Aviv"];

		// ---------------------------------------------------------------
		//
		// IDataProvider
		//
		// ---------------------------------------------------------------

		public function numItems(list:IList):int
		{
			return _cities.length;
		}

		public function itemAt(list:IList, index:int):Object
		{
			return _cities[index];
		}

		public function labelFieldAt(list:IList, index:int):String
		{
			return null;
		}
	}
}
