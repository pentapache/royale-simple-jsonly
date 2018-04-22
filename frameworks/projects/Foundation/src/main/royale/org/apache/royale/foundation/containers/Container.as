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
package org.apache.royale.foundation.containers
{
	import org.apache.royale.core.IContainer;
	import org.apache.royale.core.IDocument;
	import org.apache.royale.core.IMXMLDocument;
	import org.apache.royale.core.IParent;
	import org.apache.royale.events.Event;
	import org.apache.royale.utils.MXMLDataInterpreter;
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	import org.apache.royale.foundation.core.UIComponent;

	/**
	 * The default property uses when additional MXML content appears within an element's
	 * definition in an MXML file.
	 */
	[DefaultProperty("mxmlContent")]

	/**
	 * A Container provides a grouping for zero or more components. Containers usually
	 * have a layout, but it is not required.
	 */
	public class Container extends UIComponent implements IContainer, IDocument, IMXMLDocument
	{
		public function Container()
		{
			super();
			addClassName("Container");
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		public function get scrollable():Boolean
		{
			return style.overflow == "auto";
		}

		public function set scrollable(value:Boolean):void
		{
			style.overflow = value ? "auto" : "normal";
			applyStyles();
		}


		//--------------------------------------------------------------------
		//
		// MXML Support
		//
		//--------------------------------------------------------------------

		private var _mxmlDescriptor:Array;
		private var _mxmlDocument:Object = this;

		public function get MXMLDescriptor():Array
		{
			return _mxmlDescriptor;
		}

		/**
		 *  @private
		 */
		public function setMXMLDescriptor(document:Object, value:Array):void
		{
			_mxmlDocument = document;
			_mxmlDescriptor = value;
		}

		public function generateMXMLAttributes(data:Array):void
		{
			MXMLDataInterpreter.generateMXMLProperties(this, data);
		}

		/**
		 *  @copy org.apache.royale.core.ItemRendererClassFactory#mxmlContent
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.8
		 *
		 *  @royalesuppresspublicvarwarning
		 */
		public var mxmlContent:Array;


		//--------------------------------------------------------------------
		//
		// UIComponent Overrides
		//
		//--------------------------------------------------------------------

		override public function initialize():void
		{
			super.initialize();
		}

		override public function addedToParent():void
		{
			MXMLDataInterpreter.generateMXMLInstances(_mxmlDocument, this, MXMLDescriptor);

			super.addedToParent();
		}

		//---------------------------------------------
		// childrenAdded - IContainer
		//---------------------------------------------

		public function childrenAdded():void
		{
			dispatchEvent(new Event("childrenAdded"));
		}

		//---------------------------------------------
		// setDocument - IDocument
		//---------------------------------------------

		private var _document:Object;
		private var _documentId:String;

		public function setDocument(document:Object, id:String = null):void
		{
			_document = document;
			_documentId = id;
		}
	}
}
