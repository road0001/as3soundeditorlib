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
 * This is a set of cue points.
 */
package com.tobydietrich.soundeditor.controller
{
   import flash.events.*;
   import flash.net.URLLoader;
   import flash.net.URLRequest;

   public class CueLoaderController extends LoaderController
   {
   	
   	private var myName:String = 'Cue Loader';
   	
      private var myXML:XML = new XML();

      private var myFractionLoaded:Number = 0;

      public function CueLoaderController(url:String) {
         var request:URLRequest = new URLRequest(url);
         var loader:URLLoader = new URLLoader(request);
         loader.addEventListener(Event.COMPLETE, eComplete);
         loader.addEventListener(ProgressEvent.PROGRESS, eProgress);
         loader.addEventListener(IOErrorEvent.IO_ERROR, eIoError);
      }

      private function eComplete(event:Event):void {
         var loader:URLLoader = URLLoader(event.target);
         myXML = XML(loader.data);
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
      
      public override function get fractionLoaded():Number {
      	return myFractionLoaded;
      }
      
      public function get cuePoints():XML { 
      	return myXML;
      }
      
      public override function get name():String {
      	return myName;
      }
0
}
}