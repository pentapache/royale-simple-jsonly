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
package org.apache.royale.simple.controls.tableClasses
{
	/**
	 * The DataTableColumn is used to provide the DataTable with a description
	 * a column in the table. Use one DataTableColumn in your MXML description
	 * of the DataTable.
	 */
	public class DataTableColumn
	{
		public function DataTableColumn()
		{
		}

		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// label
		//---------------------------------------------

		private var _label:String;

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}

		//---------------------------------------------
		// width
		//---------------------------------------------

		private var _width:Number;

        [PercentProxy("percentWidth")]
		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
			_percentWidth = Number.NaN;
		}

		//---------------------------------------------
		// percentWidth
		//---------------------------------------------

		private var _percentWidth:Number;

		public function get percentWidth():Number
		{
			return _percentWidth;
		}

		public function set percentWidth(value:Number):void
		{
			_percentWidth = value;
			_width = Number.NaN;
		}

		//---------------------------------------------
		// dataField
		//---------------------------------------------

		private var _dataField:String;

		public function get dataField():String
		{
			return _dataField;
		}

		public function set dataField(value:String):void
		{
			_dataField = value;
		}
	}
}
