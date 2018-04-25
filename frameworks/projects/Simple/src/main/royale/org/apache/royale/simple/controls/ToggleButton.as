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
	import org.apache.royale.core.ISelectable;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.events.BrowserEvent;
	}
	import org.apache.royale.simple.core.UIComponent;

	/**
	 * A change event is dispatched when the ToggleButton changes state.
	 */
	[Event("change","org.apache.royale.simple.events.Event")]

	/**
	 * A ToggleButton looks like a normal Button except it can be selected
	 * and has a different appearance in the selected state.
	 */
	public class ToggleButton extends Button implements ISelectable
	{
		public function ToggleButton()
		{
			super();
			setClassName("ToggleButton");
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// selected
		//---------------------------------------------

		private var _selected:Boolean;

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;

			if (value) addClassName("toggleSelected");
			else removeClassName("toggleSelected");
		}

		//---------------------------------------------
		// controlElement
		//---------------------------------------------

		public function get controlElement():Object
		{
			COMPILE::JS {
				return element;
			}
			COMPILE::SWF {
				return element;
			}
		}


		//--------------------------------------------------------------------
		//
		// UIComponent Overrides
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// createElement
		//---------------------------------------------

		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 */
		COMPILE::JS
		override public function createElement():WrappedHTMLElement
		{
			var button:WrappedHTMLElement = document.createElement('div') as WrappedHTMLElement;
			this.element = button;

			return element;
		}

		//---------------------------------------------
		// addedToParent
		//---------------------------------------------

		override public function addedToParent():void
		{
			super.addedToParent();

		}
	}
}
