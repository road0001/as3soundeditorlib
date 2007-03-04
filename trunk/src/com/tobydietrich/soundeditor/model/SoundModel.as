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
 * This is a sound and the position in the sound.
 */
 
 package com.tobydietrich.soundeditor.model
{
   import flash.events.*;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;

   public class SoundModel extends EventDispatcher implements IPlayableModel
   {
      // enum listing the play state
      private var myPlayState:int;
      
      // the mp3 file
      private var mySound:Sound;
       
      // The sound channel
      private var mySoundChannel:SoundChannel;

      // the number of milliseconds elapsed.
      private var myPausePosition:int;
      
      private var myVolume:Number;

      /* Constructor */
      public function SoundModel(sound:Sound) {
		   mySound = sound;
         stop();
         volume = 1.0; 
      }

      /* Getters for internal objects */
      public function get sound():Sound {
         return mySound;
      }
      
      public function get soundChannel():SoundChannel {
      	return mySoundChannel;
      }
      
      /* Volume functions */
      public function get leftPeak():Number {
      	return mySoundChannel.leftPeak;
      }
      
      public function get rightPeak():Number {
      	return mySoundChannel.rightPeak;
      }
      
      public function get volume():Number {
      	return myVolume;
      }
      
      public function set volume(newVolume:Number):void {
      	myVolume = newVolume;
      }

/* Time - based functions */
      public function get length():int {
	        return mySound.length;
      }

      public function get position():int {
         if(mySoundChannel == null) {
            return myPausePosition;
         } else {
            return mySoundChannel.position;
         }
      }

      /* this is the most important function */
      public function set position(newPosition:int):void {
         if(soundChannel != null) {
            soundChannel.stop();
            mySoundChannel = null;
         }
         myPausePosition = newPosition;
         if(newPosition == 0) {
      	   playState = PlayState.STOPPED;
      	  } else if (newPosition == length) {
      	     playState = PlayState.STOPPED;
      	  } else {
      	     playState = PlayState.PAUSED;
      	  } 
         dispatchEvent(new PlayableModelEvent(PlayableModelEvent.CHANGE));
      }
      
      /* fraction overrides */
      public function get fractionComplete():Number
      {
         return position / length;
      }
      
      public function set fractionComplete(fraction:Number):void {
         position = fraction * length;
      }
      
      // friendly functions
      public function stop():void
      {
         position = 0;
      }

      public function rewindAll():void
      {
         position = 0;
      }
      
      public function forwardAll():void {
         position = length;
      }
      
      public function pause():void {
         //  this looks silly
         position = position;
      }
      
      public function play():void {
         if(soundChannel != null) {
            return;
         }
         if(stopped) {
            rewindAll();
         }
         mySoundChannel = sound.play(position, 0, new SoundTransform(volume));
         playState = PlayState.PLAYING;
         mySoundChannel.addEventListener(Event.SOUND_COMPLETE, eComplete);
         dispatchEvent(new PlayableModelEvent(PlayableModelEvent.CHANGE));
      }
      
      public function get stopped():Boolean
      {
         return myPlayState == PlayState.STOPPED;
      }

      public function get atStart():Boolean
      {
         return playPosition == PlayPosition.AT_START;
      }

      public function get atEnd():Boolean
      {
         return playPosition == PlayPosition.AT_END;
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
      
      public function set playState(newPlayState:int):void {
      	myPlayState = newPlayState;
      }

      public function get playPosition():int {
         if(position == 0 && !playing) {
            return PlayPosition.AT_START;
         } else if (position == length) {
            return PlayPosition.AT_END;
         } else {
            return PlayPosition.IN_MIDDLE;
         }
      }
      
      private function eComplete(event:Event):void {
         position = length;
         dispatchEvent(event);
      }
      
		public function ping():void {
         dispatchEvent(new PlayableModelEvent(PlayableModelEvent.CHANGE));
		}
   }
}