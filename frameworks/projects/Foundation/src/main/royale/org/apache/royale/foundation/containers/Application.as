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
	import org.apache.royale.core.IFlexInfo;

	import org.apache.royale.core.IChild;
	import org.apache.royale.core.IContainer;
	import org.apache.royale.core.IDocument;
	import org.apache.royale.core.IParent;
	import org.apache.royale.core.IPopUpHost;
	import org.apache.royale.core.AllCSSValuesImpl;
	import org.apache.royale.core.ValuesManager;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.utils.MXMLDataInterpreter;
	import org.apache.royale.utils.Timer;
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}
	COMPILE::SWF {
		import flash.system.ApplicationDomain;
		import flash.utils.getQualifiedClassName;
	}

	import org.apache.royale.foundation.core.UIComponent;

	/**
	 * The applicationComplete event is dispatched when the application has completed its set up, which
	 * is usually after all children in the display hierarchy have been created and added.
	 */
	[Event("applicationComplete", "org.apache.royale.events.Event")]

	/**
	 * The default property uses when additional MXML content appears within an element's
	 * definition in an MXML file.
	 */
	[DefaultProperty("mxmlContent")]

	/**
	 * All Royale Foundation classes have one Application instance that forms
	 * the backdrop for the application's user interface controls and activities.
	 *
	 * Application also implements IPopUpHost which is the place you want to use to
	 * display your pop-up controls (see DateField as one example).
	 *
	 */
	public class Application extends UIComponent implements IContainer, IDocument, IPopUpHost, IFlexInfo
	{
		public function Application()
		{
			super();
			addClassName("ApplicationWrapper");

			this.instanceParent = this;
		}


		//--------------------------------------------------------------------
		//
		// IFlexInfo
		//
		//--------------------------------------------------------------------

		private var _info:Object;

		/**
		 *  An Object containing information generated
		 *  by the compiler that is useful at startup time.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		COMPILE::SWF
		public function info():Object
		{
			if (!_info)
			{
				var mainClassName:String = getQualifiedClassName(this);
				var initClassName:String = "_" + mainClassName + "_FlexInit";
				var c:Class = ApplicationDomain.currentDomain.getDefinition(initClassName) as Class;
				_info = c.info();
			}
			return _info;
		}

		COMPILE::JS
		public function info():Object
		{
			return _info;
		}


		//--------------------------------------------------------------------
		//
		// UIComponent Overrides
		//
		//--------------------------------------------------------------------

		override public function initialize():void
		{
			super.initialize();

			ValuesManager.valuesImpl = new AllCSSValuesImpl();
			ValuesManager.valuesImpl.init(this);
		}

		/**
     	 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 */
		COMPILE::JS
		override public function createElement():WrappedHTMLElement
		{
			var body:HTMLElement = document.getElementsByTagName('body')[0];
			body.className = 'Application';

			var div:WrappedHTMLElement = document.createElement('div') as WrappedHTMLElement;
			this.element = div;

			body.appendChild(element);

			return element;
		}


		//--------------------------------------------------------------------
		//
		// MXML Support
		//
		//--------------------------------------------------------------------

		protected var instanceParent:IParent = null;

		private var _mxmlDescriptor:Array;
		private var _mxmlDocument:Object = this;

		public function get MXMLDescriptor():Array
		{
			return null;
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
		// IPopUpHost
		//
		//--------------------------------------------------------------------

		/**
		 * Acts as a barrier between the popUpChild and the rest of the application. This
		 * allows events to be captured and bring the pop-up down.
		 */
		private var eventShield:UIComponent;

		/**
		 * Holds reference to the child being displayed.
		 */
		private var popUpChild:UIComponent;

		//---------------------------------------------
		// popUpAt
		//---------------------------------------------

		/**
		 * Displays the component at a specific (x,y) that is relative to the
		 * host's origin.
		 */
		public function popUpAt(component:IChild, xpos:Number, ypos:Number):void
		{
			eventShield = new UIComponent();
			eventShield.setClassName("PopUpEventShield");
			eventShield.element.addEventListener('click', handleShieldEvents);

			popUpChild = component as UIComponent;
			popUpChild.addClassName("PopUp");

			addElement(eventShield);
			addElement(popUpChild);

			popUpChild.x = xpos;
			popUpChild.y = ypos;

			COMPILE::JS {
				popUpChild.style.position = "absolute";
				popUpChild.style.zIndex = "9999";
			}
		}

		//---------------------------------------------
		// popUpCentered
		//---------------------------------------------

		/**
		 * Displays the component centered within the host's space.
		 */
		public function popUpCentered(component:IChild):void
		{
			eventShield = new UIComponent();
			eventShield.setClassName("PopUpEventShield");
			eventShield.element.addEventListener('click', handleShieldEvents);

			popUpChild = component as UIComponent;
			popUpChild.addClassName("PopUp");

			addElement(eventShield);
			addElement(popUpChild);

			COMPILE::JS {
				popUpChild.style.zIndex = "9999";
				popUpChild.element.style.top = "50%";
				popUpChild.element.style.left = "50%";
				popUpChild.element.style.margin = "-" + String(popUpChild.height/2)+
					"px 0 0 -"+String(popUpChild.width/2)+"px";
			}
			COMPILE::SWF {
				var xpos:Number = (this.width - popUpChild.width)/2;
				var ypos:Number = (this.height - popUpChild.height)/2;
				popUpChild.x = xpos;
				popUpChild.y = ypos;
			}
		}

		//---------------------------------------------
		// popDown
		//---------------------------------------------

		/**
		 * Brings down the poped-up child. Use this instead of removing the child
		 * yourself.
		 */
		public function popDown(component:IChild):void
		{
			if (eventShield) {
				eventShield.element.removeEventListener('click', handleShieldEvents);
				removeElement(eventShield);
				eventShield = null;
			}
			if (popUpChild) {
				removeElement(popUpChild);
				popUpChild = null;
			}
		}

		//---------------------------------------------
		// handleShieldEvents
		//---------------------------------------------

		private function handleShieldEvents(event:MouseEvent):void
		{
			popDown(popUpChild);
		}


		//--------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------

		private var startupTimer:Timer;

		//---------------------------------------------
		// start
		//---------------------------------------------

		public function start():void
		{
			if (dispatchEvent(new org.apache.royale.events.Event("preinitialize", false, true)))
				finishStart();
			else {
				startupTimer = new Timer(34, 0);
				startupTimer.addEventListener("timer", handleStartupTimer);
				startupTimer.start();
			}
		}

		protected function handleStartupTimer(event:Event):void
		{
			if (dispatchEvent(new org.apache.royale.events.Event("preinitialize", false, true)))
			{
				startupTimer.stop();
				finishStart();
			}
		}

		//---------------------------------------------
		// initialize
		//---------------------------------------------

		/**
		 * @royaleignorecoercion org.apache.royale.core.IBead
		 */
		protected function finishStart():void
		{
			MXMLDataInterpreter.generateMXMLInstances(this, instanceParent, MXMLDescriptor);

			dispatchEvent(new org.apache.royale.events.Event('initialize'));

			addedToParent();

			dispatchEvent(new org.apache.royale.events.Event("applicationComplete"));
		}

		//---------------------------------------------
		// childrenAdded - IContainer
		//---------------------------------------------

		public function childrenAdded():void
		{
			dispatchEvent(new org.apache.royale.events.Event("childrenAdded"));
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
