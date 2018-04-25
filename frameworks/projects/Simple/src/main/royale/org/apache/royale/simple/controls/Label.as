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
	}

	/**
	 * The Label displays a single line of text. To display multiple lines with wrapping
	 * ability and justification, use TextBlock instead.
	 */
	public class Label extends UIComponent
	{
		public function Label()
		{
			super();
			addClassName("Label");
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
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			COMPILE::JS {
				element.innerHTML = value;
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
			var span:WrappedHTMLElement = document.createElement('span') as WrappedHTMLElement;
			this.element = span;

			return element;
		}
	}
}
