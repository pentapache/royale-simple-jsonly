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
	 * A ButtonBar presents a list of controls horizontally with no gaps. This
	 * is accomplished by using the pre-defined style, ButtonBarLayout.
	 *
	 * Data for the ButtonBar comes from the dataProvider property which is an object
	 * that implements the IDataProvider interface. Since ButtonBar only creates buttons
	 * there is no need to supply an IItemRendererFactory.
	 */
	public class ButtonBar extends HBox implements IList
	{
		public function ButtonBar()
		{
			super();

			// toss out the classNames from the superclasses and start here
			setClassName("ButtonBar");
		}

		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		private var needsGeneration:Boolean = true;

		//---------------------------------------------
		// dataProvider
		//---------------------------------------------

		private var _dataProvider:IDataProvider;

		public function get dataProvider():IDataProvider
		{
			return _dataProvider;
		}

		public function set dataProvider(value:IDataProvider):void
		{
			if (value != _dataProvider) {
				_dataProvider = value;
				needsGeneration = true;

				generateButtons();
			}
		}

		//---------------------------------------------
		// selectedIndex
		//---------------------------------------------

		private var _selectedIndex:int = -1;

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

		public function set selectedIndex(value:int):void
		{
			_selectedIndex = value;
		}


		//--------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// newButtonRenderer
		//---------------------------------------------

		/**
		 * Subclasses can override this method to return a different type of Button.
		 */
		protected function newButtonRenderer() : Button
		{
			return new Button();
		}

		//---------------------------------------------
		// setEventHandler
		//---------------------------------------------

		/**
		 * Subclasses can override this method to set up the event handler on
		 * the button renderer.
		 */
		protected function setEventHandler(button:Button):void
		{
			button.addEventListener("click", clickHandler);
		}

		//---------------------------------------------
		// generateButtons
		//---------------------------------------------

		protected function generateButtons():void
		{
			if (!needsGeneration) return;

			removeAllElements();

			if (dataProvider == null) return;

			for(var i:int=0; i < dataProvider.numItems(this); i++) {
				var button:Button = newButtonRenderer();
				var item:Object = dataProvider.itemAt(this,i);
				var labelField:String = dataProvider.labelFieldAt(this,i);
				if (item is String) {
					button.label = String(item);
				}
				else if (labelField) {
					button.label = item[labelField];
				}
				setEventHandler(button);
				addElement(button, false); // do not send an event for this this
			}

			needsGeneration = false;

			//?? maybe send an event out now ??
		}

		//--------------------------------------------------------------------
		//
		// UIComponent overrides
		//
		//--------------------------------------------------------------------

		override public function addedToParent():void
		{
			super.addedToParent();

			addEventListener("componentAdded", performLayout);
			addEventListener("childrenAdded", performLayout);

			generateButtons();
		}

		//--------------------------------------------------------------------
		//
		// Event handling
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// clickHandler
		//---------------------------------------------

		protected function clickHandler(event:MouseEvent):void
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

		//---------------------------------------------
		// performLayout
		//---------------------------------------------

		protected function performLayout(event:Event):void
		{
			generateButtons();
		}
	}
}
