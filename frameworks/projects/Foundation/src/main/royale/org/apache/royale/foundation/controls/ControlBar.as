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
////////////////////////////////////////////////////////////////////////////////'
package org.apache.royale.foundation.controls
{
	import org.apache.royale.core.IChild;
	import org.apache.royale.foundation.containers.FlexBox;

	/**
	 * Overrides the superclass's default property.
	 */
	[DefaultProperty("controls")]

	/**
	 * The ControlBar is a horizontal space where you can add controls
	 * (typically buttons and labels). Its primary purpose is to appear
	 * at the bottom of a Panel.
	 */
	public class ControlBar extends FlexBox
	{
		public function ControlBar()
		{
			super();
			setClassName("ControlBar");
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// controls (default property)
		//---------------------------------------------

		private var _controls:Array;

		public function get controls():Array
		{
			return _controls;
		}

		public function set controls(value:Array):void
		{
			_controls = value;
		}


		//--------------------------------------------------------------------
		//
		// UIComponent overrides
		//
		//--------------------------------------------------------------------

		override public function addedToParent():void
		{
			super.addedToParent();

			if (controls)
			{
				for(var i:int=0; i < controls.length; i++)
				{
					addElement(controls[i] as IChild);
				}
			}
		}
	}
}
