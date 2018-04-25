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
package org.apache.royale.simple.core
{
	COMPILE::SWF {
		import flash.display.DisplayObject;
	}
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IBeadLayout;
	import org.apache.royale.core.IBeadModel;
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.core.IStyleableObject;
	import org.apache.royale.core.IChild;
	import org.apache.royale.core.IParent;
	import org.apache.royale.core.IPopUpHost;
	import org.apache.royale.utils.StringTrimmer;
	import org.apache.royale.utils.loadBeadFromValuesManager;

	import org.apache.royale.events.Event;
	import org.apache.royale.events.EventDispatcher;
	import org.apache.royale.events.IEventDispatcher;

	/**
	 * Dispatched when the component has been added to its parent.
	 */
	[Event("componentAdded", "org.apache.royale.core.Event")]

	/**
	 * Dispatched when the component has been removed its parent.
	 */
	[Event("componentRemoved", "org.apache.royale.core.Event")]

	/**
	 * Dispatched when the component has had its initial configuration
	 * completed.
	 */
	[Event("initialized", "org.apache.royale.core.Event")]

	/**
	 * Dispatched when the component's width has been changed. This event is
	 * only sent when the width property has been changed, not when the
	 * component's size is changed by the browser.
	 */
	[Event("widthChanged", "org.apache.royale.core.Event")]

	/**
	 * Dispatched when the component's height has been changed. This event is
	 * only sent when the height property has been changed, not when the
	 * component's size is changed by the browser.
	 */
	[Event("heightChanged", "org.apache.royale.core.Event")]

	/**
	 * Dispatched when a child element has been added.
	 */
	[Event("elementAdded", "org.apache.royale.core.Event")]

	/**
	 * Dispatched when a child element has been removed.
	 */
	[Event("elementRemoved", "org.apache.royale.core.Event")]

	/**
	 * UIComponent is the basis for all of the visual element - controls, containers, etc.
	 * in Royale Foundation.
	 */
	public class UIComponent extends EventDispatcher implements IUIBase, IStyleableObject
	{
		/**
		 * Constructor.
		 */
		public function UIComponent()
		{
			super();
			initialize();
			createElement();
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// element - JS
		//---------------------------------------------

		COMPILE::JS
		private var _element:WrappedHTMLElement;

		/**
		 * Creates the platform-specific element. The default is a <div>
		 *
     	 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 */
		COMPILE::JS
		public function createElement():WrappedHTMLElement
		{
			_element = document.createElement('div') as WrappedHTMLElement;
			_element.royale_wrapper = this;

			return _element;
		}

		COMPILE::JS
		public function get element():WrappedHTMLElement
		{
			return _element;
		}

		COMPILE::JS
		public function set element(value:WrappedHTMLElement):void
		{
			_element = value;
		}

		COMPILE::JS
		public function get positioner():WrappedHTMLElement
		{
			return _element;
		}

		COMPILE::JS
        public function set positioner(value:WrappedHTMLElement):void
        {
        	trace("UIComponent.positioner being set");
        }

		//---------------------------------------------
		// element - SWF
		//---------------------------------------------

		COMPILE::SWF
		private var _element:DisplayObject;

		/**
		 * Creates the platform-specific element. The default is a DisplayObject
		 */
		COMPILE::SWF
		public function createElement():DisplayObject
		{
			return new DisplayObject();
		}

		COMPILE::SWF
		public function get element():DisplayObject
		{
			return _element;
		}

		COMPILE::SWF
		public function set element(value:DisplayObject):void
		{
			_element = value;
		}

		COMPILE::SWF
        public function get $displayObject():DisplayObject
        {
        	trace("UIComponent.$displayObject getter");
        	return _element;
        }

		//---------------------------------------------
		// parent
		//---------------------------------------------

		private var _parent:UIComponent;

		public function get parent():IParent
		{
			return _parent;
		}

		public function set parent(value:IParent):void
		{
			_parent = value as UIComponent;
		}

		public function addedToParent():void
		{
			applyStyles();

			loadBeadFromValuesManager(IBeadModel, "iBeadModel", this);
			loadBeadFromValuesManager(IBeadLayout, "iBeadLayout", this);
			loadBeadFromValuesManager(IBeadController, "iBeadController", this);

			dispatchEvent(new Event("componentAdded"));
		}

		public function removedFromParent():void
		{
			dispatchEvent(new Event("componentRemoved"));
		}

		//---------------------------------------------
		// children
		//---------------------------------------------

		private var _children:Array;

		public function get children():Array
		{
			if (_children == null) _children = [];
			return _children;
		}

		//---------------------------------------------
		// className
		//---------------------------------------------

		/*
		 * A note about className. There are 5 ways to work with an element's
		 * CSS className:
		 *
		 * addClassName("name") appends the name to the list of names already
		 *    set as the className. This allows subclasses to build upon each
		 *    other with the final subclass having the most authority.
		 * setClassName("name") replaces the entire className set with the name
		 *    given. This is useful if a subclass does not want to have any of
		 *    its supers classNames.
		 * removeClassName("name") removes the given name from the list. Using a
		 *    combination of addClassName and removeClassName you can turn on and
		 *    off various styles and effects.
		 * clearClassName() removes every className from the element leaving it in
		 *    its default state (perhaps affected by other CSS styles).
		 *
		 * .className="name" This property is primarily for MXML (and AS) developers
		 *    to ensure this class name takes precedent above all others.
		 */

		private var _classNameList:Array = [];

		private var _className:String = "";

		public function get className():String
		{
			return _className;
		}

		public function set className(value:String):void
		{
			if (value == null) value = "";
			_className = value;

			COMPILE::JS {
				var css:String = (_classNameList.join(" ") + " " + _className).trim();
				element.setAttribute('class',(_classNameList.join(" ") + " " + _className).trim());
			}
		}

		public function get fullClassName():String
		{
			return StringTrimmer.trim(_classNameList.join(" ") + " " + _className);
		}

		//---------------------------------------------
		// id
		//---------------------------------------------

		private var _id:String;

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;

			COMPILE::JS {
				if (element) {
					element.id = value;
				}
			}
		}

		//---------------------------------------------
		// style
		//---------------------------------------------

		private var _style:Style;

		public function get style():Object
		{
			if (_style == null) _style = new Style(this);
			return _style;
		}

		public function set style(value:Object):void
		{
			if (value is Style) {
				_style = value as Style;
				_style.component = this;
			}
		}

		public function applyStyles():void
		{
			if (style) {
				(style as Style).applyStyles();
			}
		}

		//---------------------------------------------
		// alpha
		//---------------------------------------------

		private var _alpha:Number = 1.0

		public function get alpha():Number
		{
			return style.alpha;
		}

		public function set alpha(value:Number):void
		{
			style.alpha = value;
			applyStyles();
		}

		//---------------------------------------------
		// rotation
		//---------------------------------------------

		private var _rotation:Number = 0;

		/**
		 * Rotation angle, in degrees (not radians).
		 */
		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			if (value != _rotation) {
				_rotation = value;

				COMPILE::JS {
					element.style.transform = "rotate("+String(rotation)+"deg)";
				}
			}
		}

		//---------------------------------------------
		// x
		//---------------------------------------------

		public function get x():Number
		{
			return style.x;
		}

		public function set x(value:Number):void
		{
			style.x = value;
			applyStyles();
		}

		//---------------------------------------------
		// y
		//---------------------------------------------

		public function get y():Number
		{
			return style.y;
		}

		public function set y(value:Number):void
		{
			style.y = value;
			applyStyles();
		}

		//---------------------------------------------
		// width
		//---------------------------------------------

		[Bindable("widthChanged")]
        [PercentProxy("percentWidth")]
		public function get width():Number
		{
			return style.width;
		}

		public function set width(value:Number):void
		{
			style.width = value;
			applyStyles();

			dispatchEvent(new Event("widthChanged"))
		}

		//---------------------------------------------
		// height
		//---------------------------------------------

		[Bindable("heightChanged")]
        [PercentProxy("percentHeight")]
		public function get height():Number
		{
			return style.height;
		}

		public function set height(value:Number):void
		{
			style.height = value;
			applyStyles();

			dispatchEvent(new Event("heightChanged"));
		}

		//---------------------------------------------
		// percentWidth
		//---------------------------------------------

		public function get percentWidth():Number
		{
			return style.percentWidth;
		}

		public function set percentWidth(value:Number):void
		{
			style.percentWidth = value;
			applyStyles();
		}

		//---------------------------------------------
		// percentHeight
		//---------------------------------------------

		public function get percentHeight():Number
		{
			return style.percentHeight;
		}

		public function set percentHeight(value:Number):void
		{
			style.percentHeight = value;
			applyStyles();
		}

		//---------------------------------------------
		// right
		//---------------------------------------------

		public function get right():Number
		{
			return style.right;
		}

		public function set right(value:Number):void
		{
			style.right = value;
			applyStyles();
		}

		//---------------------------------------------
		// bottom
		//---------------------------------------------

		public function get bottom():Number
		{
			return style.bottom;
		}

		public function set bottom(value:Number):void
		{
			style.bottom = value;
			applyStyles();
		}

		//---------------------------------------------
		// minWidth
		//---------------------------------------------

		public function get minWidth():Number
		{
			COMPILE::JS {
				var mw:Object = element.style['min-width'];
				var value:Number = Number(element.style.minWidth);
				return value;
			}
			COMPILE::SWF {
				return 0;
			}
		}

		//---------------------------------------------
		// minHeight
		//---------------------------------------------

		public function get minHeight():Number
		{
			COMPILE::JS {
				var value:Number = Number(element.style.minHeight);
				return value;
			}
			COMPILE::SWF {
				return 0;
			}
		}

		//---------------------------------------------
		// maxWidth
		//---------------------------------------------

		public function get maxWidth():Number
		{
			COMPILE::JS {
				var mw:Object = element.style['max-width'];
				var value:Number = Number(element.style.maxWidth);
				return value;
			}
			COMPILE::SWF {
				return 0;
			}
		}

		//---------------------------------------------
		// maxHeight
		//---------------------------------------------

		public function get maxHeight():Number
		{
			COMPILE::JS {
				var value:Number = Number(element.style.maxHeight);
				return value;
			}
			COMPILE::SWF {
				return 0;
			}
		}

		//---------------------------------------------
		// visible
		//---------------------------------------------

		private var _oldDisplay:String = null;
		private var _visible:Boolean = true;

		public function get visible():Boolean
		{
			return _visible;
		}

        public function set visible(value:Boolean):void
        {
        	_visible = value;

        	COMPILE::JS {
        		if (value) {
        			if (_oldDisplay) element.style.display = _oldDisplay;
        			else element.style.display = "block";
        		} else {
        			if (element.style.display != "none") _oldDisplay = element.style.display;
        			element.style.display = "none";
        		}
        	}
        }

		//---------------------------------------------
		// enabled
		//---------------------------------------------

		private var _enabled:Boolean = true;

        public function get enabled():Boolean
        {
        	return _enabled;
        }

        public function set enabled(value:Boolean):void
        {
        	_enabled = value;

        	COMPILE::JS {
        		if (value) element.removeAttribute('disabled');
        		else element.setAttribute('disabled', 'true');
        	}
        }

		//---------------------------------------------
		// topMostEventDispatcher
		//---------------------------------------------

        public function get topMostEventDispatcher():IEventDispatcher
        {
        	// TBD
        	return null;
        }

		//--------------------------------------------------------------------
		//
		// Beads
		//
		//--------------------------------------------------------------------

		private var _beads:Array;

		public function get beads():Array
		{
			return _beads;
		}

		public function set beads(value:Array):void
		{
			for(var i:int=0; i < value.length; i++) {
				addBead(value[i] as IBead);
			}
		}

		//---------------------------------------------
		// addBead - IStrand
		//---------------------------------------------

		public function addBead(bead:IBead):void
		{
			if (_beads == null) _beads = [];
			_beads.push(bead);

			if ((bead is IBeadModel) && (_model == null)) {
				_model = bead as IBeadModel;
			}

			bead.strand = this;
		}

		//---------------------------------------------
		// getBeadByType - IStrand
		//---------------------------------------------

		public function getBeadByType(classOrInterface:Class):IBead
		{
			if (_beads == null) return null;
			for(var i:int=0; i < _beads.length; i++) {
				if (_beads[i] is classOrInterface) return _beads[i] as IBead;
			}
			return null;
		}

		//---------------------------------------------
		// removeBead - IStrand
		//---------------------------------------------

		public function removeBead(bead:IBead):IBead
		{
			if (_beads == null) return null;
			for(var i:int=0; i < _beads.length; i++) {
				if (_beads[i] == bead) {
					_beads.splice(i,1);
					bead.strand = null;
					return bead;
				}
			}
			return null;
		}

		//---------------------------------------------
		// model - IStrand
		//---------------------------------------------

		private var _model:Object;

		public function get model():Object
		{
			if (_model == null) {
				var bead:IBead = loadBeadFromValuesManager(IBeadModel, "iBeadModel", this);
				_model = bead;
			}
			return _model;
		}

		public function set model(value:Object):void
		{
			if (value != _model) {
				_model = value;
			}
		}

		//---------------------------------------------
		// layout - IStrand
		//---------------------------------------------

		private var _layout:Object;

		public function get layout():Object
		{
			if (_layout == null) {
				var bead:IBead = loadBeadFromValuesManager(IBeadLayout, "iBeadLayout", this);
				_layout = bead;
			}
			return _layout;
		}

		public function set layout(value:Object):void
		{
			if (value != _layout) {
				_layout = value;
			}
		}

		//---------------------------------------------
		// controller - IStrand
		//---------------------------------------------

		private var _controller:Object;

		public function get controller():Object
		{
			if (_controller == null) {
				var bead:IBead = loadBeadFromValuesManager(IBeadLayout, "iBeadController", this)
				_controller = bead;
			}
			return _controller;
		}

		public function set controller(value:Object):void
		{
			if (value != _controller) {
				_controller = value;
			}
		}


		//--------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------

		public function initialize():void
		{
			// called from constructor before the element is created.
		}

		//---------------------------------------------
		// findPopUpHost
		//---------------------------------------------

		/**
		 * Finds the closest ancestor in the display chain that implements the
		 * IPopUpHost interface.
		 *
		 * @royaleignorecoercion org.apache.royale.simple.core.UIComponent
		 * @royaleignorecoercion org.apache.royale.core.IPopUpHost
		 */
		public function findPopUpHost():IPopUpHost
		{
			var p:UIComponent = this;
			while (p != null) {
				if (p is IPopUpHost) return p as IPopUpHost;
				p = p.parent as UIComponent;
			}
			return null;
		}

		//---------------------------------------------
		// setClassName
		//---------------------------------------------

		/**
		 * Replaces the entire className set with the given string.
		 */
		public function setClassName(value:String):void
		{
			var parts:Array = value.split(" ");
			_classNameList = parts;

			_className = "";

			COMPILE::JS {
				var css:String = (_classNameList.join(" ") + " " + _className).trim();
				element.setAttribute('class',(_classNameList.join(" ") + " " + _className).trim());
			}
		}

		//---------------------------------------------
		// clearClassName
		//---------------------------------------------

		public function clearClassName():void
		{
			_className = "";
			_classNameList = [];

			COMPILE::JS {
				element.className = null;
			}
		}

		//---------------------------------------------
		// addClassName
		//---------------------------------------------

		public function addClassName(nameToAdd:String):void
		{
			if (_classNameList.indexOf(nameToAdd) < 0) {
				_classNameList.push(nameToAdd);
			}

			COMPILE::JS {
				var css:String = (_classNameList.join(" ") + " " + _className).trim();
				element.setAttribute('class', (_classNameList.join(" ") + " " + _className).trim());
			}
		}

		//---------------------------------------------
		// removeClassName
		//---------------------------------------------

		public function removeClassName(nameToRemove:String):void
		{
			if (_className == nameToRemove) {
				_className = "";
			}
			else {
				var pos:Number = _classNameList.indexOf(nameToRemove);
				if (pos >= 0) {
					_classNameList.splice(pos,1);
				}
			}

			COMPILE::JS {
				var css:String = (_classNameList.join(" ") + " " + _className).trim();
				element.setAttribute('class',(_classNameList.join(" ") + " " + _className).trim());
			}
		}

		//---------------------------------------------
		// addElement - IParent
		//---------------------------------------------

		public function addElement(c:IChild, dispatchEvent:Boolean = true):void
		{
			if (c.parent) {
				c.parent.removeElement(c);
			}
			c.parent = this;

			COMPILE::JS {
				element.appendChild(c.element);
			}

			if (_children == null) _children = [];
			_children.push(c);

			c.addedToParent();

			if (dispatchEvent) this.dispatchEvent(new Event("elementAdded"));
		}

		//---------------------------------------------
		// addElementAt - IParent
		//---------------------------------------------

		public function addElementAt(c:IChild, index:int, dispatchEvent:Boolean = true):void
		{
			if (c.parent) {
				c.parent.removeElement(c);
			}
			c.parent = this;

			if (_children == null) _children = [];

			var existingElement:IChild = getElementAt(index);

			COMPILE::JS {
				if (existingElement) {
					element.insertBefore(c.element, existingElement.element);
					_children.splice(index,0,c);
				}
				else {
					element.appendChild(c.element);
					_children.push(c);
				}
			}

			c.addedToParent();

			if (dispatchEvent) this.dispatchEvent(new Event("elementAdded"));
		}

		//---------------------------------------------
		// getElementIndex - IParent
		//---------------------------------------------

		public function getElementIndex(c:IChild):int
		{
			if (_children == null) return -1;

			for(var i:int=0; i < _children.length; i++) {
				if (c == _children[i]) return i;
			}
			return -1;
		}

		//---------------------------------------------
		// removeElement - IParent
		//---------------------------------------------

		public function removeElement(c:IChild, dispatchEvent:Boolean = true):void
		{
			var index:int = getElementIndex(c);
			if (index < 0) return;

			_children.splice(index,1);

			COMPILE::JS {
				_element.removeChild(c.element);
			}

			if (dispatchEvent) this.dispatchEvent(new Event("elementRemoved"));

			c.removedFromParent();
		}

		//---------------------------------------------
		// removeAllElements
		//---------------------------------------------

		public function removeAllElements():void
		{
			for(var i:int=0; i < children.length; i++) {
				var c:IUIBase = children[i] as IUIBase;
				COMPILE::JS {
					element.removeChild(c.element);
				}
				c.removedFromParent();
			}

			_children = [];

			this.dispatchEvent(new Event("elementsRemoved"));
		}

		//---------------------------------------------
		// numElements - IParent
		//---------------------------------------------

		public function get numElements():int
		{
			if (_children == null) return 0;
			return _children.length;
		}

		//---------------------------------------------
		// getElementAt - IParent
		//---------------------------------------------

		public function getElementAt(index:int):IChild
		{
			if (_children == null) return null;
			return _children[index] as IChild;
		}

	}
}
