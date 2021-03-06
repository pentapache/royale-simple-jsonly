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
package org.apache.royale.core
{
    /**
     *  The IPopUpHost interface is a "marker" interface for a component that
     *  parents components that implement IPopUp.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.0
     */
    public interface IPopUpHost extends IParent
	{
		/**
		 * Presents the component on top of all other all children at the given (x,y)
		 * position relative to the upper-left corner of the IPopUpHost.
		 */
		function popUpAt(component:IChild, xpos:Number, ypos:Number):void;

		/**
		 * Presents the component on top of all other children centered within the
		 * IPopUpHost's space.
		 */
		function popUpCentered(component:IChild):void;

		/**
		 * Removes the component popUp from the display.
		 */
		function popDown(component:IChild):void;
	}
}
