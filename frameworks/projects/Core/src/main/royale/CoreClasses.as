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
package {

/**
 *  @private
 *  This class is used to link additional classes into rpc.swc
 *  beyond those that are found by dependency analysis starting
 *  from the classes specified in manifest.xml.
 */
internal class CoreClasses
{

	// ---------------------------------------------------------
	// Interfaces
	// ---------------------------------------------------------


	import org.apache.royale.core.AllCSSValuesImpl; AllCSSValuesImpl;
    import org.apache.royale.core.IBead; IBead;
    import org.apache.royale.core.IBeadController; IBeadController;
	import org.apache.royale.core.IBeadLayout; IBeadLayout;
    import org.apache.royale.core.IBeadModel; IBeadModel;
	import org.apache.royale.core.IBeadView; IBeadView;
	import org.apache.royale.core.IBinding; IBinding;
    import org.apache.royale.core.IChild; IChild;
    import org.apache.royale.core.IContainer; IContainer;
    import org.apache.royale.core.IDocument; IDocument;
    import org.apache.royale.core.IFlexInfo; IFlexInfo;
    import org.apache.royale.core.IParent; IParent;
    import org.apache.royale.core.IStrand; IStrand;
    import org.apache.royale.core.ISelectable; ISelectable;
    import org.apache.royale.core.Strand; Strand;
	COMPILE::JS {
		import org.apache.royale.core.ElementWrapper; ElementWrapper;
		import org.apache.royale.core.WrappedHTMLElement; WrappedHTMLElement;
	    import org.apache.royale.core.IRoyaleElement; IRoyaleElement;
	}

	// ---------------------------------------------------------
	// Events
	// ---------------------------------------------------------

	import org.apache.royale.events.CustomEvent; CustomEvent;
    import org.apache.royale.events.Event; Event;
	import org.apache.royale.events.CloseEvent; CloseEvent;
	import org.apache.royale.events.CollectionEvent; CollectionEvent;
    import org.apache.royale.events.ProgressEvent; ProgressEvent;
	import org.apache.royale.events.StyleChangeEvent; StyleChangeEvent;
    import org.apache.royale.events.EventDispatcher; EventDispatcher;
    import org.apache.royale.events.IEventDispatcher; IEventDispatcher;
	import org.apache.royale.events.MouseEvent; MouseEvent;
	import org.apache.royale.events.KeyboardEvent; KeyboardEvent;
	import org.apache.royale.events.DetailEvent; DetailEvent;
	import org.apache.royale.events.ValueEvent; ValueEvent;
	import org.apache.royale.events.utils.KeyboardEventConverter; KeyboardEventConverter;
	import org.apache.royale.events.utils.MouseEventConverter; MouseEventConverter;
	import org.apache.royale.events.utils.KeyConverter; KeyConverter;
    import org.apache.royale.events.utils.MouseUtils; MouseUtils;
	import org.apache.royale.events.utils.EditingKeys; EditingKeys;
	import org.apache.royale.events.utils.ModifierKeys; ModifierKeys;
	import org.apache.royale.events.utils.NavigationKeys; NavigationKeys;
	import org.apache.royale.events.utils.SpecialKeys; SpecialKeys;
	import org.apache.royale.events.utils.WhitespaceKeys; WhitespaceKeys;
	import org.apache.royale.events.utils.UIKeys; UIKeys;
	COMPILE::JS {
		import org.apache.royale.events.BrowserEvent; BrowserEvent;
        import org.apache.royale.events.utils.EventUtils; EventUtils;
	}

	// ---------------------------------------------------------
	// Geom
	// ---------------------------------------------------------

	import org.apache.royale.geom.Matrix; Matrix;
    import org.apache.royale.geom.Point; Point;
    import org.apache.royale.geom.Rectangle; Rectangle;

	// ---------------------------------------------------------
	// Utils
	// ---------------------------------------------------------

    import org.apache.royale.utils.CSSUtils; CSSUtils;
    import org.apache.royale.utils.StringPadder; StringPadder;
	import org.apache.royale.utils.StringTrimmer; StringTrimmer;
	import org.apache.royale.utils.StringUtil; StringUtil;
	import org.apache.royale.utils.ObjectMap; ObjectMap;
	import org.apache.royale.utils.ObjectUtil; ObjectUtil;
	import org.apache.royale.utils.PointUtils; PointUtils;
	import org.apache.royale.utils.Timer; Timer;
	import org.apache.royale.utils.UIDUtil; UIDUtil;
	import org.apache.royale.utils.UIUtils; UIUtils;
	import org.apache.royale.utils.URLUtils; URLUtils;
	import org.apache.royale.utils.MXMLDataInterpreter; MXMLDataInterpreter;

    import org.apache.royale.core.TextLineMetrics; TextLineMetrics;

	// ---------------------------------------------------------
	// Package-level Functions
	// ---------------------------------------------------------

	import org.apache.royale.debugging.assert; assert;
	import org.apache.royale.debugging.assertType; assertType;
	import org.apache.royale.debugging.check; check;
	import org.apache.royale.debugging.notNull; notNull;
	import org.apache.royale.debugging.throwError; throwError;

	import org.apache.royale.utils.loadBeadFromValuesManager; loadBeadFromValuesManager;

	import org.apache.royale.utils.array.rangeCheck; rangeCheck;

	import org.apache.royale.utils.string.contains; contains;
	import org.apache.royale.utils.string.isWhitespace; isWhitespace;
	import org.apache.royale.utils.string.trim; trim;
	import org.apache.royale.utils.string.trimRight; trimRight;
	import org.apache.royale.utils.string.trimLeft; trimLeft;

	import org.apache.royale.utils.date.addDays; addDays;
	import org.apache.royale.utils.date.addHours; addHours;
	import org.apache.royale.utils.date.addMinutes; addMinutes;
	import org.apache.royale.utils.date.addMonths; addMonths;
	import org.apache.royale.utils.date.addSeconds; addSeconds;
	import org.apache.royale.utils.date.addYears; addYears;
}

}

