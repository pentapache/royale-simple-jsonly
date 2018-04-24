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
package org.apache.royale.foundation.containers.dividedBoxClasses
{
	import org.apache.royale.core.IChild;
	import org.apache.royale.core.IUIBase;

	/**
	 * Creates the divider bar/controller between the children of HDividedBox.
	 */
	public class HDividedBar extends DividedBar
	{
		public function HDividedBar()
		{
			super();
			addClassName("HDividedBar");

			gripper.setClassName("HDividedBar_gripper");
			gripper.width = 5;
			gripper.height = 11;
		}

		override protected function redraw():void
		{
			var center:Number = Math.ceil(5/2);
			var middle:Number = Math.ceil(11/2);

			var y1:Number = middle-5;
			var y2:Number = middle+5;

			var newPath:String = "M "+String(center-2)+" "+String(y1)+" L "+String(center-2)+" "+String(y2)+" "+
			                     "M "+String(center)+" "+String(y1)+" L "+String(center)+" "+String(y2)+" "+
			                     "M "+String(center+2)+" "+String(y1)+" L "+String(center+2)+" "+String(y2)+" Z";
			//resetPath(newPath);
			gripper.path = newPath;

			super.redraw();
		}

		override protected function adjustChildBefore(newWidth:Number, newHeight:Number):void
		{
			(beforeChild as IUIBase).width = newWidth;
		}

		override protected function adjustChildAfter(newWidth:Number, newHeight:Number):void
		{
			(afterChild as IUIBase).width = newWidth;
		}
	}
}
