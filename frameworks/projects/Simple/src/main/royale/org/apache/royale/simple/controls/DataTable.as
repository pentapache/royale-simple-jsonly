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
	import org.apache.royale.core.IChild;
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.events.Event;
	COMPILE::JS {
		import org.apache.royale.events.BrowserEvent;
		import org.apache.royale.core.WrappedHTMLElement;
	}
	import org.apache.royale.simple.core.IItemRenderer;
	import org.apache.royale.simple.core.IDataTableItemRendererFactory;
	import org.apache.royale.simple.core.IList;
	import org.apache.royale.simple.core.UIComponent;
	import org.apache.royale.simple.controls.tableClasses.DataTableColumn;
	import org.apache.royale.simple.controls.tableClasses.DataTableHeaderRenderer;
	import org.apache.royale.simple.controls.tableClasses.DataTableItemRenderer;
	import org.apache.royale.simple.controls.tableClasses.DataTableStringHeaderRenderer;
	import org.apache.royale.simple.controls.tableClasses.DataTableStringItemRenderer;
	import org.apache.royale.simple.controls.tableClasses.DataTable$Body;
	import org.apache.royale.simple.controls.tableClasses.DataTable$Header;
	import org.apache.royale.simple.controls.tableClasses.DataTable$Row;

	/**
	 * The change event is dispatched when a row has been selected. Use the
	 * selectIndex and selectedCol properties to determine which row or cell
	 * has been selected.
	 */
	[Event("change","org.apache.royale.events.Event")]

	/**
	 * The complete event is dispatched when the table has been generated.
	 */
	[Event("complete", "org.apache.royale.events.Event")]

	/**
	 * The default property are the column definitions.
	 */
	[DefaultProperty("columns")]

	/**
	 * This class presents a multi-column list. The class requires an
	 * itemRendererFactory - a class that implements IDataTableItemRendererFactory
	 * which supplies instances of itemRenderers to display the data.
	 */
	public class DataTable extends UIComponent implements IList
	{
		public function DataTable()
		{
			super();
			addClassName("DataTable");
		}

		//--------------------------------------------------------------------
		//
		// UIComponent overrides
		//
		//--------------------------------------------------------------------

		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 */
		COMPILE::JS
		override public function createElement():WrappedHTMLElement
		{
			this.element = document.createElement("table") as WrappedHTMLElement;

			element.addEventListener('click', handleClick);
			element.royale_wrapper = this;

			return element;
		}

		override public function addedToParent():void
		{
			super.addedToParent();

			COMPILE::JS {
				tableHeader = new DataTable$Header();
				addElement(tableHeader, false);

				tableBody = new DataTable$Body();
				addElement(tableBody, false);
			}
		}

		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		private var needsGeneration:Boolean = true;
		private var tableHeader:DataTable$Header;
		private var tableBody:DataTable$Body;


		//---------------------------------------------
		// itemRendererFactory
		//---------------------------------------------

		private var _itemRendererFactory:IDataTableItemRendererFactory;

		public function get itemRendererFactory():IDataTableItemRendererFactory
		{
			return _itemRendererFactory;
		}

		public function set itemRendererFactory(value:IDataTableItemRendererFactory):void
		{
			if (value != _itemRendererFactory) {
				_itemRendererFactory = value;
				needsGeneration = true;
				generateTable();
			}
		}

		//---------------------------------------------
		// columns
		//---------------------------------------------

		private var _columns:Array;

		public function get columns():Array
		{
			return _columns;
		}

		public function set columns(value:Array):void
		{
			_columns = value;
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

			var row:DataTable$Row;

			// don't forget to de-select the previous renderer
			if (selectedIndex >= 0) {
				row = tableBody.getElementAt(selectedIndex) as DataTable$Row;
				row.deselect();
			}

			_selectedIndex = value;

			if (selectedIndex >= 0) {
				row = tableBody.getElementAt(value) as DataTable$Row;
				row.select();
			}

			dispatchEvent(new Event("change"));
		}

		//---------------------------------------------
		// selectedCol
		//---------------------------------------------

		private var _selectedCol:int = -1;

		public function get selectedCol():Number
		{
			return _selectedCol;
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
			if (!value) {
				_selectedCol = -1;
				selectedIndex = -1;
			}
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
			generateTable();
		}

		//---------------------------------------------
		// generateTable
		//---------------------------------------------

		COMPILE::JS
		protected function generateTable():void
		{
			if (!needsGeneration) return;
			if (itemRendererFactory == null) return;
			if (columns == null) return;

	 		tableHeader.removeAllElements();
	 		tableBody.removeAllElements();

 			generateHeader();
 			generateBody();

			needsGeneration = false;

			dispatchEvent(new Event("complete"));
		}

		COMPILE::SWF
		protected function generateTable():void
		{
			// TBD
		}

		//---------------------------------------------
		// generateHeader
		//---------------------------------------------

		COMPILE::JS
		protected function generateHeader():void
		{
			var numCols:int = columns.length;
 			var row:DataTable$Row = new DataTable$Row();

 			for (var h:int=0; h < numCols; h++)
 			{
 				var col:DataTableColumn = columns[h] as DataTableColumn;
 				var header:IItemRenderer = itemRendererFactory.headerRendererAt(this, h, col);
 				if (header == null) {
 					header = new DataTableStringHeaderRenderer();
 					header.data = col.label;
 				}
				header.list = this;
				header.index = h;

 				if (!isNaN(col.width)) header.width = col.width;
 				else if (!isNaN(col.percentWidth)) header.percentWidth = col.percentWidth;

 				if (header is DataTableHeaderRenderer) {
 					row.addElement(header, false);
 				}
 				else {
 					var th:DataTableHeaderRenderer = new DataTableHeaderRenderer();
 					th.addElement(header);
 					row.addElement(th, false);
 				}
 			}

 			tableHeader.addElement(row, false);
		}

		//---------------------------------------------
		// generateBody
		//---------------------------------------------

		COMPILE::JS
		protected function generateBody():void
		{
			var numCols:int = columns.length;
 			var numRows:int = itemRendererFactory.numItems(this);

 			for (var r:int=0; r < numRows; r++)
 			{
 				var row:DataTable$Row = new DataTable$Row();
 				row.list = this;
 				row.index = r;

 				for (var c:int=0; c < numCols; c++)
 				{
 					var cell:IItemRenderer = itemRendererFactory.itemRendererAt(this, r, c);
 					cell.list = this;
 					cell.index = r;

 					if (cell is DataTableItemRenderer) {
 						(cell as DataTableItemRenderer).colIndex = c;
 						row.addElement(cell, false);
 					}
 					else {
 						var td:DataTableItemRenderer = new DataTableItemRenderer();
 						td.list = this;
 						td.index = r;
 						td.colIndex = c;
 						td.addElement(cell, false);
 						row.addElement(td);
 					}
 				}

				tableBody.addElement(row, false);
 			}
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
					if (wrapper is DataTableItemRenderer) {
						var renderer:DataTableItemRenderer = wrapper as DataTableItemRenderer;
						_selectedCol = renderer.colIndex;
						selectedIndex = renderer.index;
						break;
					}
				}
				target = target.parentNode;
			}
		}
	}
}
