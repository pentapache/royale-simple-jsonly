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
package org.apache.royale.foundation.controls.tableClasses
{
	import org.apache.royale.core.IChild;
	import org.apache.royale.foundation.core.IList;
	import org.apache.royale.foundation.core.UIComponent;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	/**
	 * The DataTable$Row creates a row component for the DataTable. THe
	 * presence of the $ in the name indicates this is an internal-use class.
	 */
	public class DataTable$Row extends UIComponent implements IChild
	{
		public function DataTable$Row()
		{
			super();
			className = "DataTableRow";
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// index
		//---------------------------------------------

		private var _index:int;

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}

		//---------------------------------------------
		// list
		//---------------------------------------------

		private var _list:IList;

		public function get list():IList
		{
			return _list;
		}

		public function set list(value:IList):void
		{
			_list = value;
		}


		//--------------------------------------------------------------------
		//
		// UIComponent overrides
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
			this.element = document.createElement("tr") as WrappedHTMLElement;
			element.royale_wrapper = this;
			return element;
		}


		//--------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// select
		//---------------------------------------------

		public function select():void
		{
			addClassName("listSelect");
		}

		//---------------------------------------------
		// deselect
		//---------------------------------------------

		public function deselect():void
		{
			removeClassName("listSelect");
		}
	}
}
