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
package org.apache.royale.foundation.core
{
	/**
	 * Provides IItemRenderer instances on demand for the DataTable.
	 *
	 * Note that the functions all pass the list being used as their first parameter,
	 * allowing the provider to differentiate between lists if need be.
	 */
	public interface IDataTableItemRendererFactory
	{
		/**
		 * Returns the number of items being provided.
		 */
		function numItems(list:IList):int;

		/**
		 * Returns the itemRenderer at the given index. The function can return
		 * any type of IItemRenderer, including a derivative of DataTableItemRenderer.
		 * You may not return null but should instead return an instance of the
		 * default itemRenderer class.
		 */
		function itemRendererAt(list:IList, rowIndex:int, colIndex:int):IItemRenderer;

		/**
		 * Returns the itemRenderer for the header of a column. The columnDef will be
		 * an instance of DataTableColumn. You may return null from this function to
		 * use the default headerRenderer class.
		 */
		function headerRendererAt(list:IList, colIndex:int, columnDef:Object):IItemRenderer;
	}
}
