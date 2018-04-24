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
    import org.apache.royale.events.IEventDispatcher;

    COMPILE::SWF {
        import flash.display.DisplayObject;
    }

    /**
     *  The IUIBase interface is the basic interface for user interface components.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.0
     */
	public interface IUIBase extends IStrand, IEventDispatcher, IParent, IChild
	{

		/**
		 * Creates the native element and returns it.
		 */
		COMPILE::JS
		function createElement():WrappedHTMLElement;

		COMPILE::SWF
		function createElement():DisplayObject;

		/**
		 * Adds direct styling to the component.
		 */
		function get style():Object;
		function set style(value:Object):void;

		/**
		 * Augment the component's style class.
		 */
		function get className():String;
		function set className(value:String):void;

		/**
		 * Add this to the end of the className list
		 */
		function addClassName(nameToAdd:String):void;

		/**
		 * Replace the className list with this new name.
		 */
		function setClassName(newName:String):void;

		/**
		 * Removes a className from the list of style classes if present.
		 */
		function removeClassName(nameToRemove:String):void;

		/**
		 *  The alpha or opacity in the range of 0 to 1.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		function get alpha():Number;
		function set alpha(value:Number):void;

		/**
		 * Rotation angle, in degrees (not radians).
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		function get rotation():Number;
		function set rotation(value:Number):void;

		/**
		 *  The x co-ordinate or left side position of the bounding box.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		function get x():Number;
		function set x(value:Number):void;

		/**
		 *  The y co-ordinate or top position of the bounding box.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		function get y():Number;
		function set y(value:Number):void;

		/**
		 *  The width of the bounding box.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		function get width():Number;
		function set width(value:Number):void;

		/**
		 * The height of the bounding box.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		function get height():Number;
		function set height(value:Number):void;

		/**
		 *  The width of the bounding box as a percent of its parent.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		function get percentWidth():Number;
		function set percentWidth(value:Number):void;

		/**
		 * The height of the bounding box as a percent of its parent.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		function get percentHeight():Number;
		function set percentHeight(value:Number):void;

		/**
		 * The minimum width of the component.
		 */
		function get minWidth():Number;

		/**
		 * The minimum height of the component.
		 */
		function get minHeight():Number;

		/**
		 * The maximum width of the component.
		 */
		function get maxWidth():Number;

		/**
		 * The maximum height of the component.
		 */
		function get maxHeight():Number;

        /**
         *  Whether the component is visible.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        function get visible():Boolean;
        function set visible(value:Boolean):void;

        /**
         * Whether or not the component will respond to interactions.
         * The default is true.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        function get enabled():Boolean;
        function set enabled(value:Boolean):void;

        /**
         *  The top most event dispatcher.  Good for trying to capture
         *  all input events.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        function get topMostEventDispatcher():IEventDispatcher;

        /**
		 *  Set positioner of IUIBase. This can be useful for beads such as MaskBead
		 *  that change the parent element after it's been drawn.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9
         *  all input events.
         *
         */
		COMPILE::JS
        function set positioner(value:WrappedHTMLElement):void;

		/**
		 * Called immediately after the element has been created.
		 */
        function initialize():void;
    }
}
