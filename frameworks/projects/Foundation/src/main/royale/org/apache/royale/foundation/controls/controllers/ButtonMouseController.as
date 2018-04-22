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
package org.apache.royale.foundation.controls.controllers
{
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.EventDispatcher;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.MouseEvent;
	COMPILE::JS {
		import org.apache.royale.events.BrowserEvent;
	}

	/**
	 * The ButtonMouseController watches for mouse related events on its
	 * strand and dispatches click (and potentially other) events.
	 */
	public class ButtonMouseController extends EventDispatcher implements IBeadController
	{
		public function ButtonMouseController()
		{
			super();
		}

		//---------------------------------------------
		// strand
		//---------------------------------------------

		private var _strand:IStrand;

		public function get strand():IStrand
		{
			return _strand;
		}

		public function set strand(value:IStrand):void
		{
			_strand = value;

			COMPILE::JS {
				(strand as IUIBase).element.addEventListener("click", clickHandler);
			}
		}

		//---------------------------------------------
		// clickHandler
		//---------------------------------------------

		COMPILE::JS
		private function clickHandler(event:BrowserEvent):void
		{
			var newEvent:MouseEvent = new MouseEvent("click", false, false,
                                   event.clientX, event.clientY,
                                   null,
                                   event.ctrlKey, event.metaKey, event.shiftKey,
                                   false, 0,
                                   false, event.ctrlKey,
                                   1, EventDispatcher(strand));
			(strand as IEventDispatcher).dispatchEvent(newEvent);
		}
	}
}
