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
package org.apache.royale.simple.controls.accessories
{
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IUIBase;

	/**
	 * The LowercaseOnlyBead sets its input control's mask to display uppercase letters
	 */
	public class LowercaseOnlyBead implements IBead
	{
		public function LowercaseOnlyBead()
		{
		}


		//--------------------------------------------------------------------
		//
		// Properties
		//
		//--------------------------------------------------------------------

		//---------------------------------------------
		// strand
		//---------------------------------------------

		private var _strand:IStrand;

		public function get strand():IStrand
		{
			return _strand;
		}

		/**
		 * @royaleignorecoercion window.HTMLInputElement
		 * @royaleignorecoercion org.apache.royale.core.IUIBase
		 */
		public function set strand(value:IStrand):void
		{
			_strand = value;

			COMPILE::JS {
				var input:HTMLInputElement = (strand as IUIBase).element as HTMLInputElement;
				input.style.textTransform = "lowercase";
			}
		}
	}
}
