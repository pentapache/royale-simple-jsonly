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
	import org.apache.royale.utils.CSSUtils;
	import org.apache.royale.foundation.core.UIComponent;

	/**
	 * Style is used to provide in-line styling to a specific element. You can do this either
	 * programmatically:
	 *
	 *     var style:Style = new Style();
	 *     style.backgroundColor = "orange";
	 *     component.style = style;
	 *
	 * or via MXML:
	 *
	 * 	   <rf:Container>
	 *         <rf:style><rf:Style backgroundColor="orange" /></rf:style>
	 *         ...
	 *     </rf:Container>
	 */
	public class Style
	{
		public function Style(component:IUIBase=null)
		{
			_component = component;
		}

		private var _component:IUIBase;

		public function get component():IUIBase
		{
			return _component;
		}
		public function set component(value:IUIBase):void
		{
			_component = value;
		}

		//--------------------------------------------------------------------
		//
		// Apply style
		//
		//--------------------------------------------------------------------

		public function applyStyles():void
		{
			COMPILE::JS {
				if (_style && styleChanged) component.element.style.cssText = _style;

				if (!isNaN(width) && widthChanged) component.element.style.width = String(width)+"px";
				if (!isNaN(height) && heightChanged) component.element.style.height = String(height)+"px";
				if (!isNaN(top)) component.element.style.top = String(top)+"px";
				if (!isNaN(left)) component.element.style.left = String(left)+"px";
				if (!isNaN(right) && rightChanged) component.element.style.right = String(right)+"px";
				if (!isNaN(bottom) && bottomChanged) component.element.style.bottom = String(bottom)+"px";
				if (!isNaN(percentWidth)) component.element.style.width = String(percentWidth)+"%";
				if (!isNaN(percentHeight)) component.element.style.height = String(percentHeight)+"%";
				if (!isNaN(lineHeight)) component.element.style["line-height"] = String(lineHeight)+"px";
				if (!isNaN(opacity)) component.element.style.opacity = opacity;

				if (!isNaN(color) && colorChanged) component.element.style.color = CSSUtils.attributeFromColor(color);
				if (!isNaN(backgroundColor) && backgroundColorChanged) component.element.style.backgroundColor = CSSUtils.attributeFromColor(backgroundColor);
				if (textAlign) component.element.style["text-align"] = textAlign;
				if (overflow) component.element.style["overflow"] = overflow;
				if (border && borderChanged) component.element.style.border = border;
				if (!isNaN(padding) && paddingChanged) component.element.style.padding = String(padding)+"px";

				if (fill && fillChanged) component.element.style.setProperty('fill', fill);
				if (stroke && strokeChanged) component.element.style.setProperty('stroke', stroke);
				if (!isNaN(fillOpacity) && fillOpacityChanged) component.element.style.setProperty('fill-opacity',String(fillOpacity));
				if (!isNaN(strokeWidth) && strokeWidthChanged) component.element.style.setProperty('stroke-width',String(strokeWidth));
			}

			// reset all
			styleChanged = false;
			widthChanged = false;
			heightChanged = false;
			rightChanged = false;
			bottomChanged = false;
			colorChanged = false;
			backgroundColorChanged = false;
			borderChanged = false;
			paddingChanged = false;
			fillChanged = false;
			strokeChanged = false;
			fillOpacityChanged = false;
			strokeWidthChanged = false;
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		private var styleChanged:Boolean = false;
		private var widthChanged:Boolean = false;
		private var heightChanged:Boolean = false;
		private var rightChanged:Boolean = false;
		private var bottomChanged:Boolean = false;
		private var colorChanged:Boolean = false;
		private var backgroundColorChanged:Boolean = false;
		private var borderChanged:Boolean = false;
		private var paddingChanged:Boolean = false;
		private var fillChanged:Boolean = false;
		private var strokeChanged:Boolean = false;
		private var fillOpacityChanged:Boolean = false;
		private var strokeWidthChanged:Boolean = false;

		//---------------------------------------------
		// style
		//---------------------------------------------

		private var _style:String;

		/**
		 * The "style" is a catch-all that allows any valid style sequence
		 * to be used which isn't covered by the specific properties.
		 */
		public function set style(value:String):void
		{
			if (value != _style) {
				_style = value;
				styleChanged = true;
			}
		}

		//---------------------------------------------
		// backgroundColor
		//---------------------------------------------

		private var _backgroundColor:uint;

		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		public function set backgroundColor(value:uint):void
		{
			if (value != _backgroundColor) {
				_backgroundColor = value;
				backgroundColorChanged = true;
			}
		}

		//---------------------------------------------
		// color
		//---------------------------------------------

		private var _color:uint;

		public function get color():uint
		{
			return _color;
		}
		public function set color(value:uint):void
		{
			if (value != _color) {
				_color = value;
				colorChanged = true;
			}
		}

		//---------------------------------------------
		// border
		//---------------------------------------------

		private var _border:String;

		public function get border():String
		{
			return _border;
		}

		public function set border(value:String):void
		{
			if (value != _border) {
				_border = value;
				borderChanged = true;
			}
		}

		//---------------------------------------------
		// padding
		//---------------------------------------------

		private var _padding:Number;

		public function get padding():Number
		{
			return _padding;
		}

		public function set padding(value:Number):void
		{
			if (value != _padding) {
				_padding = value;
				paddingChanged = true;
			}
		}

		//---------------------------------------------
		// alpha or opacity
		//---------------------------------------------

		private var _opacity:Number;

		public function get opacity():Number
		{
			return _opacity;
		}
		public function set opacity(value:Number):void
		{
			_opacity = value;
		}

		public function get alpha():Number
		{
			return _opacity;
		}
		public function set alpha(value:Number):void
		{
			_opacity = value;
		}

		//---------------------------------------------
		// x or left
		//---------------------------------------------

		private var _left:Number;

		public function get left():Number
		{
			return _left;
		}
		public function set left(value:Number):void
		{
			_left = value;
		}

		public function get x():Number
		{
			return _left;
		}
		public function set x(value:Number):void
		{
			_left = value;
		}

		//---------------------------------------------
		// y or top
		//---------------------------------------------

		private var _top:Number;

		public function get top():Number
		{
			return _top;
		}
		public function set top(value:Number):void
		{
			_top = value;
		}

		public function get y():Number
		{
			return _top;
		}
		public function set y(value:Number):void
		{
			_top = value;
		}

		//---------------------------------------------
		// width
		//---------------------------------------------

		private var _width:Number;

		public function get width():Number
		{
			if (isNaN(_width)) {
				COMPILE::JS {
					return component.element.offsetWidth;
				}
				COMPILE::SWF {
					return 0;
				}
			}
			return _width;
		}

		public function set width(value:Number):void
		{
			if (value != _width) {
				_width = value;
				_percentWidth = Number.NaN;
				widthChanged = true;
			}
		}

		//---------------------------------------------
		// height
		//---------------------------------------------

		private var _height:Number;

		public function get height():Number
		{
			if (isNaN(_height)) {
				COMPILE::JS {
					return component.element.offsetHeight;
				}
				COMPILE::SWF {
					return 0;
				}
			}
			return _height;
		}

		public function set height(value:Number):void
		{
			if (value != _height) {
				_height = value;
				_percentHeight = Number.NaN;
				heightChanged = true;
			}
		}

		//---------------------------------------------
		// right
		//---------------------------------------------

		private var _right:Number;

		public function get right():Number
		{
			return _right;
		}

		public function set right(value:Number):void
		{
			if (value != _right) {
				_right = value;
				rightChanged = true;
			}
		}

		//---------------------------------------------
		// bottom
		//---------------------------------------------

		private var _bottom:Number;

		public function get bottom():Number
		{
			return _bottom;
		}

		public function set bottom(value:Number):void
		{
			if (value != _bottom) {
				_bottom = value;
				bottomChanged = true;
			}
		}

		//---------------------------------------------
		// percentWidth
		//---------------------------------------------

		private var _percentWidth:Number;

		public function get percentWidth():Number
		{
			return _percentWidth;
		}

		public function set percentWidth(value:Number):void
		{
			_percentWidth = value;
			_width = Number.NaN;
		}

		//---------------------------------------------
		// percentHeight
		//---------------------------------------------

		private var _percentHeight:Number;

		public function get percentHeight():Number
		{
			return _percentHeight;
		}

		public function set percentHeight(value:Number):void
		{
			_percentHeight = value;
			_height = Number.NaN;
		}

		//---------------------------------------------
		// textAlign
		//---------------------------------------------

		private var _textAlign:String = null;

		public function get textAlign():String
		{
			return _textAlign;
		}

		public function set textAlign(value:String):void
		{
			_textAlign = value;
		}

		//---------------------------------------------
		// lineHeight
		//---------------------------------------------

		private var _lineHeight:Number;

		public function get lineHeight():Number
		{
			return _lineHeight;
		}

		public function set lineHeight(value:Number):void
		{
			_lineHeight = value;
		}

		//---------------------------------------------
		// overflow
		//---------------------------------------------

		private var _overflow:String;

		public function get overflow():String
		{
			return _overflow;
		}

		public function set overflow(value:String):void
		{
			_overflow = value;
		}

		//---------------------------------------------
		// fill
		//---------------------------------------------

		private var _fill:String;

		public function get fill():String
		{
			return _fill;
		}

		public function set fill(value:String):void
		{
			if (value != _fill) {
				_fill = value;
				fillChanged = true;
			}
		}

		//---------------------------------------------
		// stroke
		//---------------------------------------------

		private var _stroke:String;

		public function get stroke():String
		{
			return _stroke;
		}

		public function set stroke(value:String):void
		{
			if (value != _stroke) {
				_stroke = value;
				strokeChanged = true;
			}
		}

		//---------------------------------------------
		// fillOpacity
		//---------------------------------------------

		private var _fillOpacity:Number;

		public function get fillOpacity():Number
		{
			return _fillOpacity;
		}

		public function set fillOpacity(value:Number):void
		{
			if (value != _fillOpacity) {
				_fillOpacity = value;
				fillOpacityChanged = true;
			}
		}

		//---------------------------------------------
		// strokeWidth
		//---------------------------------------------

		private var _strokeWidth:Number;

		public function get strokeWidth():Number
		{
			return _strokeWidth;
		}

		public function set strokeWidth(value:Number):void
		{
			if (value != _strokeWidth) {
				_strokeWidth = value;
				strokeWidthChanged = true;
			}
		}
	}
}
