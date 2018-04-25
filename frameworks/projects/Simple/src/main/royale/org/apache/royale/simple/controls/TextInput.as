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
	import org.apache.royale.simple.core.Style;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	/**
	 * The TextInput control provides a way to accept input from the keyboard. The TextInput
	 * control has a number of accessory beads that can be used with it to alter its behavior.
	 */
	public class TextInput extends UIComponent
	{
		public function TextInput()
		{
			super();
			addClassName("TextInput");
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// text
		//---------------------------------------------

		private var _text:String;

		public function get text():String
		{
			COMPILE::JS {
				_text = (element as HTMLInputElement).value;
			}
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			COMPILE::JS {
				(element as HTMLInputElement).value = value;
			}
		}

		//---------------------------------------------
		// placeHolder
		//---------------------------------------------

		private var _placeHolder:String

		public function get placeHolder():String
		{
			return _placeHolder;
		}

		public function set placeHolder(value:String):void
		{
			_placeHolder = value;
			COMPILE::JS {
				(element as HTMLInputElement).placeholder = value;
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
			var input:WrappedHTMLElement = document.createElement('input') as WrappedHTMLElement;
			this.element = input;
			this.element["type"] = "text";

			return element;
		}
	}
}
