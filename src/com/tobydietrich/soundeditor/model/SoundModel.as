/**
 * This is a sound and the position in the sound.
 */
 
 package com.tobydietrich.soundeditor.model
{
   import flash.events.*;
   import flash.media.Sound;
   import flash.media.SoundChannel;

   public class SoundModel extends EventDispatcher implements IPlayableModel
   {
      // the mp3 file
      private var mySound:Sound = new Sound();
       
      // The sound channel
      private var mySoundChannel:SoundChannel;

      // the number of milliseconds elapsed.
      private var myPosition:int = 0;

      // enum listing the play state
      private var myPlayState:int = PlayState.STOPPED;

      // enum listing the play positioon
      private var myPlayPosition:int = PlayPosition.AT_BEGINNING;

      public function SoundModel(sound:Sound) {
		mySound = sound;
      }

      public function get sound():Sound {
         return mySound;
      }
      
      public function get soundChannel():SoundChannel {
      	return mySoundChannel;
      }
      
      public function set soundChannel(newSoundChannel:SoundChannel):void {
      	mySoundChannel = newSoundChannel;
      }
      
      public function get leftPeak():Number {
      	return mySoundChannel.leftPeak;
      }
      
      public function get rightPeak():Number {
      	return mySoundChannel.rightPeak;
      }

      public function get length():int {
	        return mySound.length;
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

public function set position(newPosition:int):void {
	myPosition = newPosition;
}
      public function get fractionComplete():Number
      {
         return position/length;
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
      
      public function set playState(playState:int):void {
      	myPlayState = playState;
      }

      public function get playPosition():int {
         return myPlayPosition;
      }
      
      public function set playPosition(playPosition:int):void {
      	myPlayPosition = playPosition;
      }
   }
}