package com.tobydietrich.soundeditor.sound
{
   import flash.events.*;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.net.*;
   import flash.display.Sprite;
   import com.tobydietrich.soundeditor.player.*;

   public class SoundTrack implements Playable
   {
      // the mp3 file
      private var mySound:Sound = new Sound();
       
       
      public function get length():int {
	        return mySound.length;
      }
       
      // The sound channel
      private var mySoundChannel:SoundChannel;

      // the AudetoApp
      private var myParent:SoundClient;
       
      private var mySoundIsLoaded:Boolean = false;

      // the number of milliseconds elapsed.
      private var myPosition:int = 0;

      // enum listing the play state
      private var myPlayState:int = PlayState.STOPPED;

      // enum listing the play positioon
      private var myPlayPosition:int = PlayPosition.AT_BEGINNING;


      public function SoundTrack(parent:SoundClient, snd_URL:String) {
         myParent = parent;
         var request:URLRequest = new URLRequest(snd_URL);
         mySound.addEventListener(Event.COMPLETE, sndCompleteHandler);
         mySound.addEventListener(Event.ID3, sndId3Handler);
         mySound.addEventListener(IOErrorEvent.IO_ERROR, sndIoErrorHandler);
         mySound.addEventListener(ProgressEvent.PROGRESS, sndProgressHandler);
         mySound.load(request);
      }

      private function sndProgressHandler(event:ProgressEvent):void {
         var nLoaded:Number = event.bytesLoaded;
         var nTotal:Number = event.bytesTotal;
         var nFraction:Number = 0;
         if (nTotal>0) {
            nFraction = nLoaded/nTotal;
         }

         myParent.sndLoaderProgress = nFraction;
      }

      private function sndCompleteHandler(event:Event):void {
         mySoundIsLoaded = true;
         //trace("completeHandler: " + event);
         myParent.checkForCompletion();
      }

      private function sndId3Handler(event:Event):void {
         //trace("id3Handler: " + event);
      }

      private function sndIoErrorHandler(event:Event):void {
         trace("Sound ioErrorHandler: " + event);
      }

      public function get sound():Sound {
         return mySound;
      }

      public function get isLoaded():Boolean {
         return mySoundIsLoaded;
      }

      private function soundCompleteHandler(event:Event):void {
         //trace("soundCompleteHandler: " + event);
         stop();
         myParent.stop();
      }

      /***
       * the number of milliseconds elapsed
       */
      public function get position():int {
         if(mySoundChannel == null) {
            return myPosition;
         } else {
            return mySoundChannel.position;
         }
      }

      public function get fractionComplete():Number
      {
         return position/length;
      }

      public function set fractionComplete(x:Number):void {
         myPosition = x*length;
         if(mySoundChannel != null) {
            mySoundChannel.stop();
         }
         	
      }

      public function stop():void
      {
         myPlayState = PlayState.STOPPED;
         if(mySoundChannel != null) {
            mySoundChannel.stop();
         }
      }

      public function rewindAll():void
      {
         // maybe start playing again??
         stop();
      }

      public function pause():void
      {
         myPosition = position;
         myPlayState = PlayState.PAUSED;
         if(myPosition==0) {
            myPlayPosition = PlayPosition.AT_BEGINNING;
         } else if(myPosition==length) {
            myPlayPosition = PlayPosition.AT_END;
         } else {
            myPlayPosition = PlayPosition.IN_MIDDLE;
         }
         if(mySoundChannel != null) {
            mySoundChannel.stop();
         }
      }

      public function play():void
      {
         if(myPlayState == PlayState.PLAYING) {
            return;
         }
         if(myPlayState==PlayState.STOPPED) {
            rewindAll();
         }
         mySoundChannel = sound.play(myPosition);
         myPlayState = PlayState.PLAYING;
         myPlayPosition = PlayPosition.IN_MIDDLE;
         mySoundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
         	
      }

      public function forwardAll():void
      {
         myPosition = length;
         myPlayState = PlayState.STOPPED;
         myPlayPosition = PlayPosition.AT_END;
         if(mySoundChannel != null) {
            mySoundChannel.stop();
         }
      }

      public function synchronize(p:Playable):void {
         p.fractionComplete = fractionComplete;
      }

      public function get stopped():Boolean
      {
         return myPlayState == PlayState.STOPPED;
      }

      public function get atBeginning():Boolean
      {
         return myPlayPosition == PlayPosition.AT_BEGINNING;
      }

      public function get atEnd():Boolean
      {
         return myPlayPosition== PlayPosition.AT_END;
      }

      public function get paused():Boolean
      {
         return myPlayState == PlayState.PAUSED;
      }

      public function get playing():Boolean
      {
         return myPlayState == PlayState.PLAYING;
      }

      public function get playState():int {
         return myPlayState;
      }

      public function get playPosition():int {
         return myPlayPosition;
      }
   }
}