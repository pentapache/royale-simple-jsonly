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
	import org.apache.royale.core.IBeadLayout;
	import org.apache.royale.simple.containers.layouts.FlexLayout;

	/**
	 * The FlexBox class is a convenience class for arranging items using the
	 * FlexLayout bead.
	 *
	 * This class makes it possible for a Container to be associated with a
	 * specific layout in CSS.
	 */
	public class FlexBox extends Container
	{
		public function FlexBox()
		{
			super();
			addClassName("FlexBox");
		}

		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// direction
		//---------------------------------------------

		private var _direction:String = "horizontal";

		public function get direction():String
		{
			return _direction;
		}

		public function set direction(value:String):void
		{
			_direction = value;
		}


		//--------------------------------------------------------------------
		//
		// UIComponent Overrides
		//
		//--------------------------------------------------------------------

		override public function addedToParent():void
		{
			var flexLayout:FlexLayout = layout as FlexLayout;
			flexLayout.direction = direction;

			super.addedToParent();
		}
	}
}
