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