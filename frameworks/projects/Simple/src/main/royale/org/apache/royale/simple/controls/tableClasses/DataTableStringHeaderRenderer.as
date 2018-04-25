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
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	/**
	 * Use the DataTableStringHeaderRenderer to set a string as the label for
	 * a column header.
	 */
	public class DataTableStringHeaderRenderer extends DataTableHeaderRenderer
	{
		public function DataTableStringHeaderRenderer()
		{
			super();
			addClassName("DataTableStringHeaderRenderer");
		}

		//--------------------------------------------------------------------
		//
		// UIComponent overrides
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// addedToParent
		//---------------------------------------------

		override public function addedToParent():void
		{
			COMPILE::JS {
				if (labelField) {
					element.innerHTML = String(data[labelField]);
				} else {
					element.innerHTML = String(data);
				}
			}
		}
	}
}
