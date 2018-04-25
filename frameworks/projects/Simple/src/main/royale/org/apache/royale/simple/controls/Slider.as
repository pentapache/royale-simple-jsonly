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

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.events.BrowserEvent;
	}

	/**
	 * A change event is dispatched whenever the value of the slider changes
	 * by user control. A single change event is dispatched when the user moves
	 * the thumb and releases. A continuous set of change events is dispatched
	 * if liveDragging is true.
	 */
	[Event("change","org.apache.royale.events.Event")]

	/**
	 * The Slider is control that present a track and thumb control to
	 * select a value from a continus set of values between a minimum
	 * and a maximum.
	 */
	public class Slider extends UIComponent
	{
		public function Slider()
		{
			super();
			addClassName("Slider");
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		COMPILE::JS
		private var nativeElement:HTMLInputElement;

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

		//---------------------------------------------
		// liveDragging
		//---------------------------------------------

		private var _liveDragging:Boolean = false;

		public function get liveDragging():Boolean
		{
			return _liveDragging;
		}

		public function set liveDragging(value:Boolean):void
		{
			_liveDragging = value;
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

			nativeElement.type = "range";
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
			if (event.type == "input" && !liveDragging) return;

			_value = Number(nativeElement.value);
			var newEvent:Event = new Event("change");
			dispatchEvent(newEvent);
		}
	}
}
