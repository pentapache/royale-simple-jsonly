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
	import org.apache.royale.foundation.controls.listClasses.DataItemRenderer;
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	/**
	 * Use the DataTableItemRenderer to provide renderers for DataTable
	 * controls. You can subclass this class if you need to add more, but do
	 * not override the createElement function as that must return a specific
	 * class of control.
	 */
	public class DataTableItemRenderer extends DataItemRenderer
	{
		public function DataTableItemRenderer()
		{
			super();
			className = "DataTableItemRenderer";
		}

		//--------------------------------------------------------------------
		//
		// properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// colIndex
		//---------------------------------------------

		private var _colIndex:Number;

		public function get colIndex():Number
		{
			return _colIndex;
		}

		public function set colIndex(value:Number):void
		{
			_colIndex = value;
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
			this.element = document.createElement("td") as WrappedHTMLElement;
			element.royale_wrapper = this;
			return element;
		}
	}
}
