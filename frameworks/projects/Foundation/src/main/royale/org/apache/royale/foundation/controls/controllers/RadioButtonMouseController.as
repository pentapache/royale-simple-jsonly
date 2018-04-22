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
	import org.apache.royale.core.ISelectable;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.EventDispatcher;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.MouseEvent;
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.events.BrowserEvent;
	}

	/**
	 * The RadioButtonMouseController observes changes to a RadioButton and updates the
	 * controls in the RadioButton's group accordingly. This class also dispatches a
	 * "change" event on the RadioButton's behalf.
	 */
	public class RadioButtonMouseController extends EventDispatcher implements IBeadController
	{
		public function RadioButtonMouseController()
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

		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 * @royaleignorecoercion org.apache.royale.core.ISelectable
		 */
		public function set strand(value:IStrand):void
		{
			_strand = value;

			COMPILE::JS {
				var control:WrappedHTMLElement = (strand as ISelectable).controlElement as WrappedHTMLElement;
				control.addEventListener("change", changeHandler);
			}
		}

		//---------------------------------------------
		// changeHandler
		//---------------------------------------------

		/**
		 * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
		 * @royaleignorecoercion org.apache.royale.core.ISelectable
		 */
		COMPILE::JS
		private function changeHandler(event:BrowserEvent):void
		{
			var control:ISelectable = strand as ISelectable;
			control.selected = true;
			(strand as IEventDispatcher).dispatchEvent(new Event("change"));
		}
	}
}
