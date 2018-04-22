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
package org.apache.royale.foundation.core
{
	import org.apache.royale.core.IUIBase;

	/**
	 * The main interface for all itemRenderers.
	 */
	public interface IItemRenderer extends IUIBase
	{
		/**
		 * The data to be presented by this itemRenderer
		 */
		function get data():Object;
		function set data(value:Object):void;

		/**
		 * The index path for this itemRenderer instance.
		 */
		function get index():int;
		function set index(value:int):void;

		/**
		 * The property within the data that holds the string
		 * to be displayed within the itemRenderer component.
		 * This is optional and depends on the itemRenderer. Return
		 * null if this is not supported.
		 */
		function get labelField():String;
		function set labelField(value:String):void;

		/**
		 * The controlling component for this itemRenderer and
		 * its siblings. This may or may not be the itemRenderer's
		 * immediate parent.
		 */
		function get list():IList;
		function set list(value:IList):void;

		/**
		 * Called when this itemRenderer has been selected
		 */
		function select():void;

		/**
		 * Called when this itemRenderer has been de-selected.
		 */
		function deselect():void;
	}
}
