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
	 * The UnitsController manages the data for the SelectList that
	 * displays the type of units used to display the results. Making
	 * this a bead is just one way to do this.
	 */
	public class UnitsController implements IBead, IDataProvider
	{
		public function UnitsController()
		{
		}

		// ---------------------------------------------------
		// result type
		// ---------------------------------------------------

		private var _unitType:String = "F"; // or "C"

		public function get unitType():String
		{
			return _unitType;
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

		private var unitTypesField:SelectList;

		/**
		 * When the app (aka strand) is ready, pull some of the UI controls and
		 * make this class the IDataProvider for the SelectList showing the different
		 * unit types. You can also make the app an IDataProvider - or some other
		 * class. Doing it this way keeps things separated.
		 */
		private function handleAppComplete(event:Event):void
		{
			unitTypesField = WeatherExample(_strand).unitTypes;
			unitTypesField.dataProvider = this;
			unitTypesField.addEventListener("change", handleListChange);
		}

		/**
		 * When the select list is changed the unit type is set and can be used
		 * later.
		 */
		private function handleListChange(event:Event):void
		{
			_unitType = _unitTypes[unitTypesField.selectedIndex].value;
		}

		// ---------------------------------------------------
		// result types
		// ---------------------------------------------------

		private var _unitTypes:Array = [
			{label: "°F/mph", value:"F"},
			{label: "°C/kph", value:"C"}];

		// ---------------------------------------------------------------
		//
		// IDataProvider
		//
		// ---------------------------------------------------------------

		public function numItems(list:IList):int
		{
			return _unitTypes.length;
		}

		public function itemAt(list:IList, index:int):Object
		{
			return _unitTypes[index];
		}

		public function labelFieldAt(list:IList, index:int):String
		{
			return "label";
		}
	}
}
