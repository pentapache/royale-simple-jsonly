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
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}

	/**
	 * Use UISVGComponent as the base class for SVG components. Rather than overriding
	 * createElement, subclasses of UISVGComponent should override createSVGElement and
	 * create their SVG content in that function.
	 */
	public class UISVGComponent extends UIComponent
	{
		public function UISVGComponent()
		{
			super();
		}

		//---------------------------------------------
		// createSVGElement
		//---------------------------------------------

		public function createSVGElement():void
		{
			// override in subclasses. Create SVG elements, such as
			// line and rect, in the subclass override. Be sure to set
			// the viewBox and perserveAspectRatio on this.element as
			// needed by the component.
		}


		//--------------------------------------------------------------------
		//
		// UIComponent Overrides
		//
		//--------------------------------------------------------------------

		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 */
		COMPILE::JS
		override public function createElement():WrappedHTMLElement
		{
			var svg:WrappedHTMLElement = document.createElementNS('http://www.w3.org/2000/svg','svg') as WrappedHTMLElement;
			this.element = svg;
			this.element.royale_wrapper = this;

			createSVGElement();

			return element;
		}

	}
}
