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
	import org.apache.royale.simple.core.UISVGComponent;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	public class Ellipse extends GraphicBase
	{
		public function Ellipse()
		{
			super();
			addClassName("Ellipse");
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
			_shape = document.createElementNS('http://www.w3.org/2000/svg', 'ellipse') as WrappedHTMLElement;
			_shape.royale_wrapper = this;
			this.element.appendChild(_shape);
		}

		//--------------------------------------------------------------------
		//
		// UIComponent overrides
		//
		//--------------------------------------------------------------------

		COMPILE::JS
		override public function addedToParent():void
		{
			super.addedToParent();

			_shape.setAttribute('cx', '50%');
			_shape.setAttribute('cy', '50%');
			_shape.setAttribute('rx', '50%');
			_shape.setAttribute('ry', '50%');
		}
	}
}
