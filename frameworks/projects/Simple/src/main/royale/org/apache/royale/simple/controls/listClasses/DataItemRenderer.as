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
package org.apache.royale.simple.controls.listClasses
{
	import org.apache.royale.simple.containers.Container;
	import org.apache.royale.simple.core.IItemRenderer;
	import org.apache.royale.simple.core.IList;
	import org.apache.royale.core.IUIBase;

	/**
	 * Use this as the base class for itemRenderers, especially if using MXML to
	 * create the renderers.
	 *
	 * Override the data setter function (call super.data = value; first!) to make
	 * use of the data and set up the interface controls within the renderer.
	 */
	public class DataItemRenderer extends Container implements IItemRenderer
	{
		public function DataItemRenderer()
		{
			super();
			className = "DataItemRenderer";
		}

		//--------------------------------------------------------------------
		//
		// Properties - IItemRenderer
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// data
		//---------------------------------------------

		private var _data:Object;

		public function get data():Object
		{
			return _data;
		}
		public function set data(value:Object):void
		{
			_data = value;
		}

		//---------------------------------------------
		// index
		//---------------------------------------------

		private var _index:int;

		public function get index():int
		{
			return _index;
		}
		public function set index(value:int):void
		{
			_index = value;
		}

		//---------------------------------------------
		// labelField
		//---------------------------------------------

		private var _labelField:String = null;

		public function get labelField():String
		{
			return _labelField;
		}

		public function set labelField(value:String):void
		{
			_labelField = value;
		}

		//---------------------------------------------
		// list
		//---------------------------------------------

		private var _list:IList;

		public function get list():IList
		{
			return _list;
		}
		public function set list(value:IList):void
		{
			_list = value;
		}

		//--------------------------------------------------------------------
		//
		// Methods - IItemRenderer
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// select
		//---------------------------------------------

		public function select():void
		{
			// override in subclass
		}

		//---------------------------------------------
		// deselect
		//---------------------------------------------

		public function deselect():void
		{
			// override in subclass
		}
	}
}
