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
	 * Provides information about the data to be presented in a list or similar
	 * control. This interface differs from IItemRendererFactory in that only
	 * data is provided which is then associated with itemRenderers that are specific
	 * to the type of control (eg, SelectList, ButtonBar).
	 *
	 * Note that the functions all pass the list being used as their first parameter,
	 * allowing the provider to differentiate between lists if need be.
	 */
	public interface IDataProvider
	{
		/**
		 * Returns the number of items being provided.
		 */
		function numItems(list:IList):int;

		/**
		 * Returns the item at the given index.
		 */
		function itemAt(list:IList, index:int):Object;

		/**
		 * Returns the name of the property to be used as the
		 * main (or only) label/description. This may return null.
		 */
		function labelFieldAt(list:IList, index:int):String;
	}
}
