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
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.events.Event;
	COMPILE::JS {
		import org.apache.royale.events.BrowserEvent;
		import org.apache.royale.core.WrappedHTMLElement;
	}
	import org.apache.royale.simple.core.IItemRenderer;
	import org.apache.royale.simple.core.IItemRendererFactory;
	import org.apache.royale.simple.core.IList;
	import org.apache.royale.simple.containers.Container;

	/**
	 * The change event is dispatched when an item of the list has been selected.
	 */
	[Event("change","org.apache.royale.events.Event")]

	/**
	 * This class presents a single column list. The class requires an
	 * itemRendererFactory - a class that implements IItemRendererFactory
	 * which supplies instances of itemRenderers to display the data.
	 */
	public class DataList extends Container implements IList
	{
		public function DataList()
		{
			super();
			addClassName("DataList");
		}

		//--------------------------------------------------------------------
		//
		// UIComponent overrides
		//
		//--------------------------------------------------------------------

		COMPILE::JS
		override public function createElement():WrappedHTMLElement
		{
			super.createElement();

			element.addEventListener('click', handleClick);

			return element;
		}

		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		private var needsGeneration:Boolean = true;

		//---------------------------------------------
		// itemRendererFactory
		//---------------------------------------------

		private var _itemRendererFactory:IItemRendererFactory;

		public function get itemRendererFactory():IItemRendererFactory
		{
			return _itemRendererFactory;
		}

		public function set itemRendererFactory(value:IItemRendererFactory):void
		{
			if (value != _itemRendererFactory) {
				_itemRendererFactory = value;
				needsGeneration = true;
				generateList();
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
			if (!selectable) return;

			var renderer:IItemRenderer;

			// don't forget to de-select the previous renderer
			if (selectedIndex >= 0) {
				renderer = getElementAt(selectedIndex) as IItemRenderer;
				renderer.deselect();
			}

			_selectedIndex = value;

			if (selectedIndex >= 0) {
				renderer = getElementAt(value) as IItemRenderer;
				renderer.select();
			}

			_selectedItem = renderer.data;

			dispatchEvent(new Event("change"));
		}

		//---------------------------------------------
		// selectedItem
		//---------------------------------------------

		private var _selectedItem:Object;

		public function get selectedItem():Object
		{
			if (selectedIndex < 0) return null;
			return _selectedItem;
		}

		//---------------------------------------------
		// selectable
		//---------------------------------------------

		private var _selectable:Boolean = true;

		public function get selectable():Boolean
		{
			return _selectable;
		}

		public function set selectable(value:Boolean):void
		{
			if (!value) selectedIndex = -1;
			_selectable = value;
		}


		//--------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// refresh
		//---------------------------------------------

		public function refresh():void
		{
			needsGeneration = true;
			generateList();
		}

		//---------------------------------------------
		// generateList
		//---------------------------------------------

		protected function generateList():void
		{
			if (!needsGeneration) return;
			if (itemRendererFactory == null) return;

			removeAllElements();

			var n:int = itemRendererFactory.numItems(this);
			for(var i:int=0; i < n; i++)
			{
				var renderer:IItemRenderer = itemRendererFactory.itemRendererAt(this,i);
				renderer.list = this;
				renderer.index = i;
				addElement(renderer, false); // do not send an event for this this
			}

			needsGeneration = false;
		}


		//--------------------------------------------------------------------
		//
		// Event handling
		//
		//--------------------------------------------------------------------

		COMPILE::JS
		private function handleClick(event:BrowserEvent):void
		{
			// starting with the event's target, work up the node tree
			// until an itemRenderer instance is found.
			var target:Node = event.target as Node;
			while (target != null) {
				if (target.hasOwnProperty("royale_wrapper")) {
					var wrapper:IUIBase = target["royale_wrapper"] as IUIBase;
					if (wrapper is IItemRenderer) {
						var renderer:IItemRenderer = wrapper as IItemRenderer;
						renderer.list.selectedIndex = renderer.index;
						break;
					}
				}
				target = target.parentNode;
			}
		}
	}
}
