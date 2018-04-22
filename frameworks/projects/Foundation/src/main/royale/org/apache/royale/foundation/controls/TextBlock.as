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
	}

	/**
	 * The TextBlock presents text in a rectangular space defined by the size of
	 * the control (if no size is specified it will be a single line unless there
	 * are new-lines embedded in the text).
	 *
	 * The text will wrap and break as necessary. The text can be just a string or
	 * it can be HTML.
	 */
	public class TextBlock extends UIComponent
	{
		public function TextBlock()
		{
			super();
			addClassName("TextBlock");
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
	}
}
