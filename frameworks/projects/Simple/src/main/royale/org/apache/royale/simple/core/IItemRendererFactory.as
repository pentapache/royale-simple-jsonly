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
package org.apache.royale.simple.core
{
	/**
	 * Provides IItemRenderer instances on demand. This differs from IDataProvider
	 * in that UI controls (aka, IItemRenders) are returned and not the actual
	 * data.
	 *
	 * Note that the functions all pass the list being used as their first parameter,
	 * allowing the provider to differentiate between lists if need be.
	 */
	public interface IItemRendererFactory
	{
		/**
		 * Returns the number of items being provided.
		 */
		function numItems(list:IList):int;

		/**
		 * Return the itemRenderer at the given index. The implementation should
		 * store any data for the itemRenderer using the itemRenderer's .data property.
		 */
		function itemRendererAt(list:IList, index:int):IItemRenderer;
	}
}
