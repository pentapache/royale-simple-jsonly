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
////////////////////////////////////////////////////////////////////////////////'
package org.apache.royale.simple.controls
{
	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.events.BrowserEvent;
	}
	import org.apache.royale.simple.core.UIComponent;

	/**
	 * VRule creates a vertical graphic that can be used as a separator in forms and
	 * other UI containers.
	 */
	public class VRule extends UIComponent
	{
		public function VRule()
		{
			super();
			addClassName("VRule");
		}
	}
}
