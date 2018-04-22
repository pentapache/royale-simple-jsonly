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
	import org.apache.royale.foundation.core.UIComponent;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	/**
	 * The DataTable$Body creates a body group within the DataTable. The
	 * $ in the name indicates this is really an internal use class.
	 */
	public class DataTable$Body extends UIComponent
	{
		public function DataTable$Body()
		{
			super();
		}

		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 */
		COMPILE::JS
		override public function createElement():WrappedHTMLElement
		{
			this.element = document.createElement("tbody") as WrappedHTMLElement;
			element.royale_wrapper = this;
			return element;
		}
	}
}