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
package org.apache.royale.foundation.containers
{
	import org.apache.royale.core.IChild;
	import org.apache.royale.foundation.containers.dividedBoxClasses.HDividedBar;

	/**
	 * The HDividedBox class lays out its children horizontally (using the HorizontalLayout
	 * beads, specified in CSS) with vertical dividers between the children.
	 */
	public class HDividedBox extends DividedBox
	{
		public function HDividedBox()
		{
			super();
			addClassName("HDividedBox");
		}

		override protected function createDivider(index:int):IChild
		{
			var bar:HDividedBar = new HDividedBar();
			return bar;
		}
	}
}
