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
package org.apache.royale.simple.controls.dateClasses
{
	import org.apache.royale.simple.controls.TextBlock;

	/**
	 * This is the itemRenderer used by the DateChooser to display the dates in
	 * the month. This renderer extends TextBlock and includes the Date object
	 * associated with the specific day of the month. If date is null it means this
	 * renderer is displaying an empty cell.
	 */
	public class DateChooserItemRenderer extends TextBlock
	{
		public function DateChooserItemRenderer()
		{
			super();
		}

		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// date
		//---------------------------------------------

		private var _date:Date;

		public function get date():Date
		{
			return _date;
		}

		public function set date(value:Date):void
		{
			_date = value;

			this.enabled = value != null;
		}
	}
}
