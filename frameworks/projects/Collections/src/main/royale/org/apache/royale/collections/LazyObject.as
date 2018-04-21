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
package org.apache.royale.collections
{
    COMPILE::SWF
    {
        import flash.events.Event;
    }

	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
    import org.apache.royale.events.Event;
	import org.apache.royale.events.EventDispatcher;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.collections.parsers.IInputParser;
    import org.apache.royale.collections.converters.IItemConverter;

    //--------------------------------------
    //  Events
    //--------------------------------------

    /**
     *  Dispatched when the collection has processed a complete event.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.0
     */
    [Event(name="complete", type="org.apache.royale.events.Event")]

    /**
     *  The LazyObject class implements a object
     *  whose content require conversion from a source data format
     *  to some other data type.  For example, converting
     *  SOAP or JSON to ActionScript data classes.
     *  The Flex SDK used to convert all of the data items
     *  when the source data arrived, which, for very large data sets
     *  or complex data classes, could lock up the user interface.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.0
     */
	public class LazyObject extends EventDispatcher implements IBead
	{
        /**
         *  Constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
		public function LazyObject()
		{
			super();
		}

		private var _inputParser:IInputParser;

        /**
         *  A lazy object uses an IInputParser to convert the source data items
         *  into a usable object.  This conversion happens as the source
         *  data arrives so it needs to be fast to avoid locking up the UI.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        public function get inputParser():IInputParser
		{
			return _inputParser;
		}

        /**
         *  @private
         */
		public function set inputParser(value:IInputParser):void
		{
			if (_inputParser != value)
			{
                _inputParser = value;
				dispatchEvent(new org.apache.royale.events.Event("inputParserChanged"));
			}
		}

        private var _itemConverter:IItemConverter;

        /**
         *  A lazy object uses an IItemConverter to convert the source data items
         *  into the desired data type.  The converter is only when needed
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        public function get itemConverter():IItemConverter
        {
            return _itemConverter;
        }

        /**
         *  @private
         */
        public function set itemConverter(value:IItemConverter):void
        {
            if (_itemConverter != value)
            {
                _itemConverter = value;
                dispatchEvent(new org.apache.royale.events.Event("itemConverterChanged"));
            }
        }

        private var _id:String;

        /**
         *  @copy org.apache.royale.core.UIBase#id
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
		public function get id():String
		{
			return _id;
		}

        /**
         *  @private
         */
		public function set id(value:String):void
		{
			if (_id != value)
			{
				_id = value;
				dispatchEvent(new org.apache.royale.events.Event("idChanged"));
			}
		}

        private var _strand:IStrand;

        /**
         *  @copy org.apache.royale.core.UIBase#strand
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        public function get strand():IStrand
        {
        	return _strand;
        }

        public function set strand(value:IStrand):void
        {
            _strand = value;
            COMPILE::SWF
            {
                IEventDispatcher(_strand).addEventListener(flash.events.Event.COMPLETE, completeHandler);
            }
            COMPILE::JS
            {
                IEventDispatcher(_strand).addEventListener("complete", completeHandler);
            }
        }

        /**
         * The data as returned from the server, unchanged.
         */
        protected var rawData:Object;

        /**
         *  The object into which the item has been converted.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        protected var data:Object;

        private function completeHandler(event:org.apache.royale.events.Event):void
        {
        	data = null;
            rawData = _strand["data"];
            dispatchEvent(event);
        }

        /**
         *  Returns the object, converting it if needed.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        public function getItem():Object
        {
        	if (data == null) {
        		data = itemConverter.convertItem(String(rawData));
        	}
            return data;
        }

	}
}
