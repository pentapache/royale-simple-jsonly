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
package org.apache.royale.simple.svg
{
	import org.apache.royale.events.Event;
	import org.apache.royale.simple.core.UISVGComponent;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	/**
	 * The Path class creates an SVG path element that can be outlined and filled using
	 * CSS. There are two ways to use Path:
	 *
	 * You can build the path as a string (eg, "M 0 0 L 10 10") and set it using the
	 * "path" property.
	 *
	 * You can build the path using the public functions such as moveTo() and lineTo() and
	 * construct the drawing in pieces. Each of these functions has a final argument, "draw",
	 * which when set to true (the default), immediately updates the drawing. If you pass
	 * false for draw, you can have the path displayed using the closePath() function.
	 *
	 * The "to" functions move to absolute positions while the "by" functions work relatively
	 * from the previous position.
	 */
	public class Path extends GraphicBase
	{
		public function Path()
		{
			super();
			addClassName("Path");

			// listen for size changes because paths are drawn with
			// explicit (x,y) values, not percentages like Ellipse and
			// Rectangle use.
			addEventListener("widthChanged", handleResize);
			addEventListener("heightChanged", handleResize);
		}

		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// path
		//---------------------------------------------

		private var _path:String;

		public function get path():String
		{
			if (_path == null) _path = "";
			return _path;
		}

		public function set path(value:String):void
		{
			if (value != _path) {
				_path = value;
				redraw();
			}
		}

		//---------------------------------------------
		// resetPath
		//---------------------------------------------

		public function resetPath(value:String):void
		{
			_path = value;
		}

		//--------------------------------------------------------------------
		//
		// Methods
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// clearPath
		//---------------------------------------------

		public function clearPath():void
		{
			_path = null;
			redraw();
		}

		//---------------------------------------------
		// closePath
		//---------------------------------------------

		public function closePath():void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "Z";
			redraw();
		}

		//---------------------------------------------
		// moveTo
		//---------------------------------------------

		public function moveTo(x:Number, y:Number, draw:Boolean=true):void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "M "+String(x)+ " " + String(y);

			if (draw) redraw();
		}

		//---------------------------------------------
		// moveBy
		//---------------------------------------------

		public function moveBy(deltaX:Number, deltaY:Number, draw:Boolean=true):void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "m "+String(deltaX)+ " " + String(deltaY);

			if (draw) redraw();
		}

		//---------------------------------------------
		// lineTo
		//---------------------------------------------

		public function lineTo(x:Number, y:Number, draw:Boolean=true):void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "L "+String(x)+ " " +String(y);

			if (draw) redraw();
		}

		//---------------------------------------------
		// lineBy
		//---------------------------------------------

		public function lineBy(deltaX:Number, deltaY:Number, draw:Boolean=true):void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "l "+String(deltaX)+ " " +String(deltaY);

			if (draw) redraw();
		}

		//---------------------------------------------
		// cubicCurveTo
		//---------------------------------------------

		public function cubicCurveTo(x:Number, y:Number, cx1:Number, cy1:Number, cx2:Number, cy2:Number, draw:Boolean=true):void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "C "+String(cx1)+" "+String(cy1) + ", "
			                   + String(cx2)+" "+String(cy2) + ", "
			                   + String(x)+" "+String(y);

			if (draw) redraw();
		}

		//---------------------------------------------
		// cubicCurveBy
		//---------------------------------------------

		public function cubicCurveBy(deltaX:Number, deltaY:Number, cx1:Number, cy1:Number, cx2:Number, cy2:Number, draw:Boolean=true):void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "c "+String(cx1)+" "+String(cy1) + ", "
			                   + String(cx2)+" "+String(cy2) + ", "
			                   + String(deltaX)+" "+String(deltaY);

			if (draw) redraw();
		}

		//---------------------------------------------
		// quadraticCurveTo
		//---------------------------------------------

		public function quadraticCurveTo(x:Number, y:Number, cx:Number, cy:Number, draw:Boolean=true):void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "Q "+String(cx)+" "+String(cy) + ", "
			                   + String(x)+" "+String(y);

			if (draw) redraw();
		}

		//---------------------------------------------
		// quadraticCurveBy
		//---------------------------------------------

		public function quadraticCurveBy(deltaX:Number, deltaY:Number, cx:Number, cy:Number, draw:Boolean=true):void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "q "+String(cx)+" "+String(cy) + ", "
			                   + String(deltaX)+" "+String(deltaY);

			if (draw) redraw();
		}

		//---------------------------------------------
		// arcTo
		//---------------------------------------------

		public function arcTo(x:Number, y:Number, radiusX:Number, radiusY:Number, rotation:Number, largeArc:int=0, sweep:int=1, draw:Boolean=true):void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "A "+String(radiusX)+" "+String(radiusY)+" "
			                   +String(rotation)+" "
			                   +String(largeArc)+" "+String(sweep)+" "
			                   +String(x)+" "+String(y);
			if (draw) redraw();
		}

		//---------------------------------------------
		// arcBy
		//---------------------------------------------

		public function arcBy(deltaX:Number, deltaY:Number, radiusX:Number, radiusY:Number, rotation:Number, largeArc:int=0, sweep:int=1, draw:Boolean=true):void
		{
			if (path.length > 0) _path = path + " ";
			_path = path + "a "+String(radiusX)+" "+String(radiusY)+" "
			                   +String(rotation)+" "
			                   +String(largeArc)+" "+String(sweep)+" "
			                   +String(deltaX)+" "+String(deltaY);
			if (draw) redraw();
		}

		//--------------------------------------------------------------------
		//
		// UISVGComponent overrides
		//
		//--------------------------------------------------------------------

		COMPILE::JS
		private var _shape:WrappedHTMLElement;

		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 */
		COMPILE::JS
		override public function createSVGElement():void
		{
			_shape = document.createElementNS('http://www.w3.org/2000/svg', 'path') as WrappedHTMLElement;
			_shape.royale_wrapper = this;
			this.element.appendChild(_shape);
		}

		//--------------------------------------------------------------------
		//
		// UIComponent overrides
		//
		//--------------------------------------------------------------------

		private var hasInitialized:Boolean = false;

		COMPILE::JS
		override public function addedToParent():void
		{
			super.addedToParent();
			hasInitialized = true;
			redraw();
		}

		//--------------------------------------------------------------------
		//
		// Drawing
		//
		//--------------------------------------------------------------------

		COMPILE::JS
		public function redraw():void
		{
			if (!hasInitialized) return;

			_shape.setAttribute('d',path);
		}

		COMPILE::SWF
		public function redraw():void
		{
		}

		//--------------------------------------------------------------------
		//
		// Event handling
		//
		//--------------------------------------------------------------------

		private function handleResize(event:Event):void
		{
			redraw();
		}
	}
}
