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
package org.apache.royale.foundation.svg
{
	import org.apache.royale.events.Event;
	import org.apache.royale.foundation.core.UISVGComponent;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	public class Polygon extends GraphicBase
	{
		public function Polygon()
		{
			super();
			addClassName("Polygon");

			// listen for size changes because polygons are drawn with
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
		// sides
		//---------------------------------------------

		private var _sides:uint = 3;

		/**
		 * Number of sides, 3 or greater. Values less than 3 are reset to 3.
		 */
		public function get sides():uint
		{
			return _sides;
		}

		public function set sides(value:uint):void
		{
			if (value != _sides) {
				_sides = value < 3 ? 3 : value;
				redraw();
			}
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
			_shape = document.createElementNS('http://www.w3.org/2000/svg', 'polygon') as WrappedHTMLElement;
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

			var numberOfSides:Number = sides,
				Xsize:Number = width/2,
				Ysize:Number = height/2,
				Xcenter:Number = width/2,
				Ycenter:Number = height/2;

			var points:String = "";

			for (var i:int = 1; i <= numberOfSides;i += 1) {
				var ptx:Number = Xcenter + Xsize * Math.cos(i * 2 * Math.PI / numberOfSides);
				var pty:Number = Ycenter + Ysize * Math.sin(i * 2 * Math.PI / numberOfSides);
				if (i > 1) points += " ";
				points = points + String(ptx) + "," + String(pty);
			}

			_shape.setAttribute('points',points);
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
