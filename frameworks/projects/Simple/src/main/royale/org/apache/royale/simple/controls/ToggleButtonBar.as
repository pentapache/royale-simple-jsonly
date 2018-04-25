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
	import org.apache.royale.events.Event;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.simple.core.IDataProvider;
	import org.apache.royale.simple.core.IList;
	import org.apache.royale.simple.containers.HBox;
	import org.apache.royale.simple.containers.layouts.HorizontalLayout;

	[Event("change","org.apache.royale.events.Event")]

	/**
	 * A ToggleButtonBar presents a list of ToggleButtons horizontally with no gaps.
	 */
	public class ToggleButtonBar extends ButtonBar
	{
		public function ToggleButtonBar()
		{
			super();
			addClassName("ToggleButtonBar");
		}

		//--------------------------------------------------------------------
		//
		// ButtonBar overrides
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// newButtonRenderer
		//---------------------------------------------

		override protected function newButtonRenderer() : Button
		{
			return new ToggleButton();
		}

		//---------------------------------------------
		// setEventHandler
		//---------------------------------------------

		override protected function setEventHandler(button:Button):void
		{
			button.addEventListener("change", changeEventHandler);
		}

		//---------------------------------------------
		// selectedIndex
		//---------------------------------------------

		override public function set selectedIndex(value:int):void
		{
			var toggle:ToggleButton;

			// first de-select the old one
			if (selectedIndex >= 0) {
				toggle = children[selectedIndex] as ToggleButton;
				toggle.selected = false;
			}

			// now select the new one
			super.selectedIndex = value;

			if (value >= 0 && value < numElements) {
				toggle = children[selectedIndex] as ToggleButton;
				toggle.selected = true;
			}
		}

		//---------------------------------------------
		// generateButtons
		//---------------------------------------------

		override protected function generateButtons():void
		{
			super.generateButtons();

			// if one is selected make sure it appears that way
			if (selectedIndex >= 0 && selectedIndex < numElements) {
				var toggle:ToggleButton = children[selectedIndex] as ToggleButton;
				toggle.selected = true;
			}
		}

		//--------------------------------------------------------------------
		//
		// Event handling
		//
		//--------------------------------------------------------------------

		protected function changeEventHandler(event:Event):void
		{
			var button:Object = event.target;
			var num:Number = numElements;
			for(var i:int=0; i < num; i++) {
				if (children[i] == button) {
					selectedIndex = i;
				}
			}

			dispatchEvent(new Event("change"));
		}
	}
}
