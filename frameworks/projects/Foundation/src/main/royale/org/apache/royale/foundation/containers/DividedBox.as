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
	import org.apache.royale.events.Event;
	import org.apache.royale.core.IChild;
	import org.apache.royale.foundation.containers.dividedBoxClasses.DividedBar;

	/**
	 * The DividedBox class is the base class for the divided boxes which
	 * place a resizing control between their children.
	 */
	public class DividedBox extends Container
	{
		public function DividedBox()
		{
			super();
			addClassName("DividedBox");

			addEventListener("elementAdded", handleAdditions);
			addEventListener("elementRemoved", handleRemovals);
		}

		private var _dividers:Array = [];

		protected function get dividers():Array
		{
			return _dividers;
		}

		override public function addedToParent():void
		{
			super.addedToParent();

			var i:int, j:int;
			var n:int = numElements;
			var numDividers:int = n - 1;
			if (n <= 1) return;

			for (j=0; j < numDividers; j++) {
				_dividers.push( createDivider(i) );
			}

			for (j=0, i=n-1; i > 0; i--, j++) {
				var divider:DividedBar = _dividers[j];
				divider.beforeChild = getElementAt(i-1);
				divider.afterChild = getElementAt(i);
				addElementAt(divider, i);
			}
		}

		protected function createDivider(index:int):IChild
		{
			// create a divider for this item
			return null;
		}

		protected function handleAdditions(event:Event):void
		{
		}

		protected function handleRemovals(event:Event):void
		{
		}
	}
}
