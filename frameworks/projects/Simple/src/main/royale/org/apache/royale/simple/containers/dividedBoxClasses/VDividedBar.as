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
package org.apache.royale.simple.containers.dividedBoxClasses
{
	import org.apache.royale.core.IChild;
	import org.apache.royale.core.IUIBase;

	/**
	 * Creates the divider bar/control between the children of a VDividedBox.
	 */
	public class VDividedBar extends DividedBar
	{
		public function VDividedBar()
		{
			super();
			addClassName("VDividedBar");

			gripper.setClassName("VDividedBar_gripper");
			//gripper.width = 11;
			//gripper.height = 5;
		}


		override protected function redraw():void
		{
			var center:Number = Math.ceil(5/2);
			var middle:Number = Math.ceil(11/2);

			var x1:Number = middle-5;
			var x2:Number = middle+5;

			var newPath:String = "M "+String(x1)+" "+String(center-2)+" L "+String(x2)+" "+String(center-2)+" "+
			                     "M "+String(x1)+" "+String(center)+" L "+String(x2)+" "+String(center)+" "+
			                     "M "+String(x1)+" "+String(center+2)+" L "+String(x2)+" "+String(center+2)+" Z";
			//resetPath(newPath);
			gripper.path = newPath;

			super.redraw();
		}

		override protected function adjustChildBefore(newWidth:Number, newHeight:Number):void
		{
			(beforeChild as IUIBase).height = newHeight;
		}

		override protected function adjustChildAfter(newWidth:Number, newHeight:Number):void
		{

			(afterChild as IUIBase).height = newHeight;
		}
	}
}
