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
package
{
	import org.apache.royale.foundation.core.IDataTableItemRendererFactory;
	import org.apache.royale.foundation.core.IItemRenderer;
	import org.apache.royale.foundation.core.IList;
	import org.apache.royale.foundation.controls.tableClasses.DataTableColumn;
	import org.apache.royale.foundation.controls.tableClasses.DataTableItemRenderer;
	import org.apache.royale.foundation.controls.tableClasses.DataTableStringItemRenderer;

	/**
	 * This is the itemRendererFactory for a DataTable. It provides both a custom
	 * cell itemRenderer and a header itemRenderer. You could imagine that even
	 * more complex data could be routed through here to display in a DataTable.
	 */
	public class SalesFactory implements IDataTableItemRendererFactory
	{
		private var _salesData:Array = [
			{year: 2014, product:"Gizmos", sales: 813},
			{year: 2014, product:"Widgets", sales: 792},
			{year: 2015, product:"Gizmos", sales: 1023},
			{year: 2015, product:"Widgets", sales: 993},
			{year: 2016, product:"Gizmos", sales: 1256},
			{year: 2016, product:"Widgets", sales: 1485}];

		// -------------------------------------------------------
		// IItemRendererFactory
		// --------------------------------------------------------

		public function numItems(list:IList):int
		{
			return _salesData.length;
		}

		/**
		 * Provides a customer header each column.
		 */
		public function headerRendererAt(list:IList, colIndex:int, columnDef:Object):IItemRenderer
		{
			var header:ColumnHeader = new ColumnHeader();
			header.data = (columnDef as DataTableColumn).label;
			return header;
		}

		/**
		 * Provides an itemRenderer for each cell of the DataTable. Most cells are
		 * of the default DataTableItemRenderer class, but one column is a ProductItem
		 * which displays an icon and a label.
		 */
		public function itemRendererAt(list:IList, rowIndex:int, colIndex:int):IItemRenderer
		{
			var cell:DataTableItemRenderer;

			var record:Object = _salesData[rowIndex];

			switch (colIndex) {
				case 0:
					cell = new DataTableStringItemRenderer();
					cell.data = record["year"];
					break;
				case 1:
					cell = new ProductItem();
					cell.data = record["product"];
					break;
				case 2:
					cell = new DataTableStringItemRenderer();
					cell.data = record["sales"];
					break;
				default:
					cell = new DataTableStringItemRenderer();
					cell.data = "unknown!";
					break;
			}

			return cell;
		}
	}
}
