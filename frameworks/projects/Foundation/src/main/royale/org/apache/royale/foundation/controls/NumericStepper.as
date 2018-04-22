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
	import org.apache.royale.foundation.core.UIComponent;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.events.BrowserEvent;
	}

	/**
	 * The change event is dispatched when the value of the NumericStepper changes.
	 */
	[Event("change","org.apache.royale.events.Event")]

	/**
	 * The input event is dispatches as the value is being changed in the input area.
	 */
	[Event("input","org.apache.royale.events.Event")]

	/**
	 * The NumericStepper is control that present an area to input a
	 * number - either from the keyboard or by using increment/decrement
	 * buttons that are part of the interface.
	 */
	public class NumericStepper extends UIComponent
	{
		public function NumericStepper()
		{
			super();
			addClassName("NumericStepper");
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		COMPILE::JS
		private var nativeElement:HTMLInputElement;

		//---------------------------------------------
		// text
		//---------------------------------------------

		public function get text():String
		{
			COMPILE::JS {
				return String(nativeElement.value);
			}
			COMPILE::SWF {
				return "";
			}
		}

		//---------------------------------------------
		// value
		//---------------------------------------------

		private var _value:Number = 0;

		public function get value():Number
		{
			return _value;
		}

		public function set value(newValue:Number):void
		{
			_value = newValue;

			COMPILE::JS {
				nativeElement.value = String(newValue);
			}
		}

		//---------------------------------------------
		// step
		//---------------------------------------------

		private var _step:Number = 1;

		public function get step():Number
		{
			return _step;
		}

		public function set step(value:Number):void
		{
			_step = value;

			COMPILE::JS {
				nativeElement.step = String(value);
			}
		}

		//---------------------------------------------
		// minimum
		//---------------------------------------------

		private var _minimum:Number = 0;

		public function get minimum():Number
		{
			return _minimum;
		}

		public function set minimum(value:Number):void
		{
			_minimum = value;

			COMPILE::JS {
				nativeElement.min = String(value);
			}
		}

		//---------------------------------------------
		// maximum
		//---------------------------------------------

		private var _maximum:Number = 100;

		public function get maximum():Number
		{
			return _maximum;
		}

		public function set maximum(value:Number):void
		{
			_maximum = value;

			COMPILE::JS {
				nativeElement.max = String(value);
			}
		}


		//--------------------------------------------------------------------
		//
		// UIComponent Overrides
		//
		//--------------------------------------------------------------------

		/**
		* @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		*/
		COMPILE::JS
		override public function createElement():WrappedHTMLElement
		{
			this.element = document.createElement('input') as WrappedHTMLElement;
			nativeElement = this.element as HTMLInputElement;

			nativeElement.type = "number";
			nativeElement.value = String(value);
			nativeElement.min = String(minimum);
			nativeElement.max = String(maximum);
			nativeElement.step = String(step);

			nativeElement.addEventListener("input", handleNativeEvent);
			nativeElement.addEventListener("change", handleNativeEvent);

			return element;
		}

		COMPILE::JS
		private function handleNativeEvent(event:BrowserEvent):void
		{
			_value = Number(nativeElement.value);
			var newEvent:Event = new Event(event.type);
			dispatchEvent(newEvent);
		}
	}
}
