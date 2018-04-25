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
package org.apache.royale.simple.controls.accessories
{
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.utils.StringUtil;
	COMPILE::JS {
		import org.apache.royale.events.BrowserEvent;
	}

	/**
	 * The NumericOnlyBead prevents non-numerals from being entered into the strand's
	 * input field. Set allowDecimal="true" (and set decimalCharacter if you require
	 * something other than '.' (period)) if you want to enter decimal numbers.
	 *
	 * NOTE: Right now, allowDecimal and decimalCharacter do not work. It always allows
	 * period ('.') to be entered.
	 */
	public class NumericOnlyBead implements IBead
	{
		public function NumericOnlyBead()
		{
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// allowDecimal
		//---------------------------------------------

		private var _allowDecimal:Boolean = false;

		public function get allowDecimal():Boolean
		{
			return _allowDecimal;
		}

		public function set allowDecimal(value:Boolean):void
		{
			_allowDecimal = value;
		}

		//---------------------------------------------
		// decimalCharacter
		//---------------------------------------------

		private var _decimalCharacter:String = ".";

		public function get decimalCharacter():String
		{
			return _decimalCharacter;
		}

		public function set decimalCharacter(value:String):void
		{
			if (value == null || value.length == 0) return;

			if (value.length > 1) {
				_decimalCharacter = value.substr(0,1);
			} else {
				_decimalCharacter = value;
			}
		}

		//---------------------------------------------
		// strand
		//---------------------------------------------

		private var _strand:IStrand;

		public function get strand():IStrand
		{
			return _strand;
		}

		/**
		 * @royaleignorecoercion window.HTMLInputElement
		 * @royaleignorecoercion org.apache.royale.core.IUIBase
		 */
		public function set strand(value:IStrand):void
		{
			_strand = value;

			COMPILE::JS {
				var input:HTMLInputElement = (strand as IUIBase).element as HTMLInputElement;
				input.addEventListener('keypress', handleKeyDown);
				input.addEventListener('paste', handlePaste);
			}
		}


		//--------------------------------------------------------------------
		//
		// Event handling
		//
		//--------------------------------------------------------------------

		COMPILE::JS
		private function handleKeyDown(event:BrowserEvent):void
		{
			// for now, allow any control-key to be passed along
			if (event.ctrlKey || event.metaKey) return;

			var code:Object = event.charCode;
			var key:String = String.fromCharCode(code);
			var regex:Object = /[0-9]|\./;
			if (!regex.test(key)) {
				event.preventDefault();
			}
		}

		/**
		 * @royaleignorecoercion window.HTMLInputElement
		 */
		COMPILE::JS
		private function handlePaste(event:BrowserEvent):void
		{
			var data:String = event["clipboardData"].getData('text/plain');
			var restricted:String = StringUtil.restrict(data, "0-9.");

			var input:HTMLInputElement = (strand as IUIBase).element as HTMLInputElement;
			var selStart:Number = input.selectionStart;
			var selEnd:Number = input.selectionEnd;
			var current:String = input.value;

			var leftPart:String = current.substring(0, selStart);
			var rightPart:String = current.substring(selEnd);

			var result:String = leftPart + restricted + rightPart;
			input.value = result;

			event.preventDefault();

		}
	}
}
