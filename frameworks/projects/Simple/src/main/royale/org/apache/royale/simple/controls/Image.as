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
////////////////////////////////////////////////////////////////////////////////'
package org.apache.royale.simple.controls
{
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.events.BrowserEvent;
	}
	import org.apache.royale.simple.core.UIComponent;

	/**
	 * The loaded event is dispatched when the image has been downloaded and has been
	 * (or about to be) presented.
	 */
	[Event("loaded","org.apache.royale.simple.events.Event")]

	/**
	 * The Image class displays some kind of browser-compatible imagery such as
	 * a JPEG, PNG, or SVG.
	 */
	public class Image extends UIComponent
	{
		public function Image()
		{
			super();
			addClassName("Image");
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// src
		//---------------------------------------------

		private var _src:String;

		public function get src():String
		{
			return _src;
		}

		public function set src(value:String):void
		{
			_src = value;

			COMPILE::JS {
				(element as HTMLImageElement).src = value;
				element.addEventListener("load", handleImageLoad);
			}
		}

		//---------------------------------------------
		// naturalWidth
		//---------------------------------------------

		public function get naturalWidth():Number
		{
			COMPILE::JS {
				return (element as HTMLImageElement).naturalWidth;
			}
			COMPILE::SWF {
				return 0;
			}
		}

		//---------------------------------------------
		// naturalHeight
		//---------------------------------------------

		public function get naturalHeight():Number
		{
			COMPILE::JS {
				return (element as HTMLImageElement).naturalHeight;
			}
			COMPILE::SWF {
				return 0;
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
			var img:WrappedHTMLElement = document.createElement('img') as WrappedHTMLElement;
			this.element = img;

			return element;
		}

		COMPILE::JS
		private function handleImageLoad(event:BrowserEvent):void
		{
			dispatchEvent(new Event("loaded"));
		}
	}
}
