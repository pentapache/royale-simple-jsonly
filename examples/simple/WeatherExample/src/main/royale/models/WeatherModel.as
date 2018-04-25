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
package models
{
	import org.apache.royale.events.Event;
	import org.apache.royale.events.EventDispatcher;

	[Event("responseDataChanged", "org.apache.royale.events.Event")]
	[Event("responseTextChanged", "org.apache.royale.events.Event")]

	/**
	 * This model handles the result from the remote call to get weather
	 * data. The data returned is JSON and this model makes it available
	 * by pulling it apart as needed.
	 */
	public class WeatherModel extends EventDispatcher
	{
		public function WeatherModel()
		{
			super();
		}

		// ---------------------------------------------------------------
		//
		// Returned data from server
		//
		// ---------------------------------------------------------------

		// ---------------------------------------------------
		// responseData
		// ---------------------------------------------------

		private var _responseData:Object = null;

		public function get responseData():Object
		{
			return _responseData;
		}

		public function set responseData(value:Object):void
		{
			if (value)
			{
				_responseData = value;
				dispatchEvent(new Event("responseDataChanged"));
				dispatchEvent(new Event("responseTextChanged"));
			}
		}

		// ---------------------------------------------------
		// unitType
		// ---------------------------------------------------

		private var _unitType:String = "F";

		public function set unitType(value:String):void
		{
			_unitType = value;
		}

		public function get unitType():String
		{
			return _unitType;
		}

		// ---------------------------------------------------
		// isError
		// ---------------------------------------------------

		public function get isError():Boolean
		{
			return _responseData.hasOwnProperty("error");
		}

		// ---------------------------------------------------
		// errorMessage
		// ---------------------------------------------------

		public function get errorMessage():String
		{
			return _responseData["error"]["message"];
		}

		// ---------------------------------------------------
		// location
		// ---------------------------------------------------

		public function get location():String
		{
			return _responseData["location"]["name"]+ ", " + _responseData["location"]["country"];
		}

		// ---------------------------------------------------
		// conditions
		// ---------------------------------------------------

		public function get conditions():String
		{
			return _responseData["current"]["condition"]["text"];
		}

		// ---------------------------------------------------
		// iconURL
		// ---------------------------------------------------

		public function get iconURL():String
		{
			var path:String = _responseData["current"]["condition"]["icon"];
			var index:Number = path.indexOf("64x64");
			if (index >= 0) {
				return "assets/" + path.substr(index);
			} else {
				return "";
			}
		}

		// ---------------------------------------------------
		// temperature
		// ---------------------------------------------------

		public function get temperature():String
		{
			if (unitType == "F")
				return _responseData["current"]["temp_f"] + "°F";
			else
				return _responseData["current"]["temp_c"] + "°C";
		}

		// ---------------------------------------------------
		// wind
		// ---------------------------------------------------

		public function get wind():String
		{
			var result:String;

			if (unitType == "F")
				result = _responseData["current"]["wind_mph"] + " mph";
			else
				result = _responseData["current"]["wind_kph"] + " kph";

			return result + " ➸" + _responseData["current"]["wind_dir"];
		}

		// ---------------------------------------------------
		// humidity
		// ---------------------------------------------------

		public function get humidity():String
		{
			return _responseData["current"]["humidity"] + "%";
		}

	}
}
