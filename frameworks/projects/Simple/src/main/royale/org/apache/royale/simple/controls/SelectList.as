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
	import org.apache.royale.simple.core.UIComponent;
	import org.apache.royale.simple.controls.listClasses.SelectListItemRenderer;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.events.BrowserEvent;
	}

	/**
	 * The change event is dispatched when an item is picked from the select list.
	 */
	[Event("change","org.apache.royale.events.Event")]

	/**
	 * A SelectList presents a pop-up menu of choices with the selected
	 * item displayed.
	 */
	public class SelectList extends UIComponent implements IList
	{
		public function SelectList()
		{
			super();
			addClassName("SelectList");
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
				generateOptions();
			}
		}

		//---------------------------------------------
		// selectedIndex
		//---------------------------------------------

		private var _selectedIndex:int = 0;

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

		public function set selectedIndex(value:int):void
		{
			_selectedIndex = value;

			COMPILE::JS {
				element["selectedIndex"] = value;
			}
		}

		//---------------------------------------------
		// size
		//---------------------------------------------

		private var _size:int = -1;

		public function get size():int
		{
			return _size;
		}

		public function set size(value:int):void
		{
			_size = value;

			COMPILE::JS {
				element["size"] = value;
			}
		}

		//--------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------

		protected function generateOptions():void
		{
			if (!needsGeneration) return;

			removeAllElements();

			if (dataProvider == null) return;

			var n:int = dataProvider.numItems(this);
			for(var i:int=0; i < n; i++)
			{
				var option:SelectListItemRenderer = new SelectListItemRenderer();
				var item:Object = dataProvider.itemAt(this,i);
				var labelField:String = dataProvider.labelFieldAt(this,i);
				option.index = i;
				option.list = this;
				option.data = item;
				option.labelField = labelField;
				addElement(option);
			}

			needsGeneration = false;

			//?? maybe send an event out now ??
		}

		COMPILE::JS
		private function handleChange(event:BrowserEvent):void
		{
			_selectedIndex = element["selectedIndex"];
			dispatchEvent(new Event("change"));
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
			this.element = document.createElement('select') as WrappedHTMLElement;
			if (size > 0) element["size"] = size;
			if (selectedIndex >= 0) element["selectedIndex"] = selectedIndex;
			this.element.addEventListener("change", handleChange);
			return element;
		}
	}
}
