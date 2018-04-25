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
package
{

/**
 *  @private
 *  This class is used to link additional classes into rpc.swc
 *  beyond those that are found by dependecy analysis starting
 *  from the classes specified in manifest.xml.
 */
internal class SimpleClasses
{
	import org.apache.royale.simple.core.IDataProvider; IDataProvider;
	import org.apache.royale.simple.core.IItemRenderer; IItemRenderer;
	import org.apache.royale.simple.core.IItemRendererFactory; IItemRendererFactory;
	import org.apache.royale.simple.core.UIComponent; UIComponent;
	import org.apache.royale.simple.core.UISVGComponent; UISVGComponent;

	import org.apache.royale.simple.controls.controllers.ButtonMouseController; ButtonMouseController;
	import org.apache.royale.simple.controls.controllers.CheckBoxMouseController; CheckBoxMouseController;
	import org.apache.royale.simple.controls.controllers.DateChooserMouseController; DateChooserMouseController;
	import org.apache.royale.simple.controls.controllers.RadioButtonMouseController; RadioButtonMouseController;
	import org.apache.royale.simple.controls.controllers.ToggleButtonMouseController; ToggleButtonMouseController;

	import org.apache.royale.simple.controls.dateClasses.DateChooserItemRenderer; DateChooserItemRenderer;
	import org.apache.royale.simple.controls.listClasses.DataItemRenderer; DataItemRenderer;
	import org.apache.royale.simple.controls.listClasses.SelectListItemRenderer; SelectListItemRenderer;
	import org.apache.royale.simple.controls.tableClasses.DataTable$Body; DataTable$Body;
	import org.apache.royale.simple.controls.tableClasses.DataTable$Header; DataTable$Header;
	import org.apache.royale.simple.controls.tableClasses.DataTable$Row; DataTable$Row;
}

}

