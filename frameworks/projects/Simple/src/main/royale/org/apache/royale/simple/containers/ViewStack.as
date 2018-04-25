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
package org.apache.royale.simple.containers
{
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.core.IChild;
	import org.apache.royale.events.Event;

	/**
	 * The change event is dispatched whenever the child becomes active.
	 */
	[Event("change","org.apache.royale.events.Event")]

	/**
	 * The ViewStack is a container that presents only one of its children at
	 * time. The child is indicated by the selectedIndex property.
	 */
	public class ViewStack extends Container
	{
		public function ViewStack()
		{
			super();
			addClassName("ViewStack");
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// selectedIndex
		//---------------------------------------------

		private var _selectedIndex:int = 0;

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

		public function set selectedIndex(value:int):void
		{
			if (value < 0 || value >= children.length) return;

			_selectedIndex = value;

			for(var i:int=0; i < children.length; i++) {
				var child:IUIBase = children[i] as IUIBase;
				child.visible = i == value;
			}

			dispatchEvent(new Event("change"));
		}


		//--------------------------------------------------------------------
		//
		// UIComponent overrides
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// addElement
		//---------------------------------------------

		override public function addElement(c:IChild, dispatchEvent:Boolean = true):void
		{
			(c as IUIBase).visible = children.length == 0;
			super.addElement(c, dispatchEvent);
		}
	}
}
