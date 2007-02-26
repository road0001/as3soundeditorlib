package com.audeto.as3soundeditorlib.sound
{
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.events.Event;
   import flash.media.SoundMixer;
   import flash.net.URLRequest;

import flash.events.*;
import flash.utils.Timer;

   public class SpectrumGraphSegment
   {
      private var mySound:Sound = new Sound();
      private var mySoundChannel:SoundChannel;
      private var myParent:SpectrumGraph;
      private var myStartTime:int = 0;
      private var myEndTime:int = 0;
	  private var positionTimer:Timer;
	  private var TIMER_INTERVAL:int = 3;

      public function SpectrumGraphSegment(parent:SpectrumGraph, snd_URL:String, startTime:int, endTime:int) {
      	myParent = parent;
         myStartTime = startTime;
         myEndTime = endTime;
         var request:URLRequest = new URLRequest(snd_URL);
         mySound.addEventListener(Event.COMPLETE, sndLoadCompleteHandler);
         mySound.addEventListener(Event.ID3, sndLoadId3Handler);
         mySound.addEventListener(IOErrorEvent.IO_ERROR, sndLoadIoErrorHandler);
         mySound.addEventListener(ProgressEvent.PROGRESS, sndLoadProgressHandler);
         mySound.load(request);
      }

      private function sndLoadProgressHandler(event:ProgressEvent):void {
         var nLoaded:Number = event.bytesLoaded;
         var nTotal:Number = event.bytesTotal;
         var nFraction:Number = 0;
         if (nTotal>0) {
            nFraction = nLoaded/nTotal;
         }
      }

      private function sndLoadCompleteHandler(event:Event):void {
         mySoundChannel =  mySound.play();  
         mySoundChannel.addEventListener(Event.SOUND_COMPLETE, sndCompleteHandler);
         positionTimer = new Timer(TIMER_INTERVAL);
         positionTimer.addEventListener(TimerEvent.TIMER, positionTimerHandler);
         positionTimer.start();
      }

      private function sndLoadId3Handler(event:Event):void {
      }

      private function sndLoadIoErrorHandler(event:Event):void {
         trace("Sound ioErrorHandler: " + event);
      }

      private function positionTimerHandler(event:TimerEvent):void {
         myParent.drawSegment(mySoundChannel.leftPeak,
          mySoundChannel.rightPeak, mySoundChannel.position);
      }
      
      private function sndCompleteHandler(event:Event):void {
      	positionTimer.stop();
      }
   }
}