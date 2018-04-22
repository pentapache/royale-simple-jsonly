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
////////////////////////////////////////////////////////////////////////////////'
package org.apache.royale.foundation.controls
{
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.events.BrowserEvent;
	}
	import org.apache.royale.foundation.core.UIComponent;

	/**
	 * Displays a message in the middle of the screen.
	 *
	 * This class supports native types of alerts. If you want something
	 * custom, you can extend this class and use it as the base for your
	 * controls. When you do this, show the alert using the functions of
	 * IPopUpHost.
	 */
	public class Alert extends UIComponent
	{
		public function Alert()
		{
			super();
		}


		//--------------------------------------------------------------------
		//
		// Static Functions
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// showNativeAlert
		//---------------------------------------------

		public static function showNativeAlert(message:String):void
		{
			COMPILE::JS {
				window.alert(message);
			}
		}

		//---------------------------------------------
		// showNativeConfirm
		//---------------------------------------------

		public static function showNativeConfirm(message:String, onYes:Function, onNo:Function):void
		{
			COMPILE::JS {
				if (confirm(message)) {
					onYes();
				} else {
					onNo();
				}
			}
		}

		//---------------------------------------------
		// showNativePrompt
		//---------------------------------------------

		public static function showNativePrompt(message:String, placeHolder:String, onResult:Function):void
		{
			COMPILE::JS {
				var value:String = prompt(message, placeHolder);
				onResult(value);
			}
		}
	}
}
