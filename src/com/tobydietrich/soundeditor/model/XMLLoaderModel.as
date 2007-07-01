/***
 *Copyright (c) 2007 Charles M. Dietrich
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the  "Software"), to 
 * deal in the Software without restriction, including without limitation the 
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
 * sell copies of the Software, and to permit persons to whom the Software is 
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in 
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
 * THE SOFTWARE.
 */ 
 /**
 * This loads XML
 */
package com.tobydietrich.soundeditor.model
{
   import flash.events.*;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import com.tobydietrich.soundeditor.view.LoaderView;

   public class XMLLoaderModel extends EventDispatcher implements LoaderModel 
   {
   	
   	private var myName:String;
   	private var myURL:String;
      private var myXML:XML = new XML();

      private var myFractionLoaded:Number = 0;

	  private var myIsComplete:Boolean = false;
	  
      public function XMLLoaderModel (name:String, url:String) {
      	myName = name;
      	myURL = url;
         var request:URLRequest = new URLRequest(url);
         var loader:URLLoader = new URLLoader(request);
         loader.addEventListener(Event.COMPLETE, eComplete);
         loader.addEventListener(ProgressEvent.PROGRESS, eProgress);
         loader.addEventListener(IOErrorEvent.IO_ERROR, eIoError);
      }

      private function eComplete(event:Event):void {
         var loader:URLLoader = URLLoader(event.target);
         myXML = XML(loader.data);
      	myIsComplete = true;   
         dispatchEvent(event);
      }
      
      public function eIoError(event:Event):void {
         dispatchEvent(event);
      }
      
      public function eProgress(event:ProgressEvent):void {
         var nTotal:Number = event.bytesTotal;
         if (nTotal>0) {
            myFractionLoaded = event.bytesLoaded / nTotal;
         }
         dispatchEvent(event);
      }
      
      public function get fractionLoaded():Number {
      	return myFractionLoaded;
      }
      
      public function get xml():XML { 
      	return myXML;
      }
      
      public function get name():String {
      	return myName;
      }
      
      public function get url():String {
      	return myURL;
      }
      
      public function get isComplete():Boolean {
      	return myIsComplete;
      }
}
}