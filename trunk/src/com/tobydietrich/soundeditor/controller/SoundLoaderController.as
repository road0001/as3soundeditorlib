/**
 * This loads the sound and notifies a controller when it is done
 */
 
 package com.tobydietrich.soundeditor.controller
{
   import flash.events.*;
   import flash.media.Sound;
   import flash.net.URLLoader;
   import flash.net.URLRequest;

   public class SoundLoaderController extends LoaderController
   {
	private var myName:String = 'Sound Loader';

      private var mySound:Sound = new Sound();

      private var myFractionLoaded:Number = 0;

      public function SoundLoaderController(url:String) {
         var request:URLRequest = new URLRequest(url);
         mySound.addEventListener(Event.COMPLETE, eComplete);
         mySound.addEventListener(Event.ID3, eId3);
         mySound.addEventListener(IOErrorEvent.IO_ERROR, eIoError);
         mySound.addEventListener(ProgressEvent.PROGRESS, eProgress);
         mySound.load(request);
      }

      private function eComplete(event:Event):void {
         dispatchEvent(event);
      }
      
      public function eIoError(event:IOErrorEvent):void {
         dispatchEvent(event);
      }
      
      public function eProgress(event:ProgressEvent):void {
         var nTotal:Number = event.bytesTotal;
         if (nTotal>0) {
            myFractionLoaded = event.bytesLoaded / nTotal;
         }
         dispatchEvent(event);
      }
      
      private function eId3(event:Event):void {
         dispatchEvent(event);
      }
      
      public override function get fractionLoaded():Number {
      	return myFractionLoaded;
      }

      public function get sound():Sound {
         return mySound;
      }
      
      public override function get name():String {
      	return myName;
      }
}
}