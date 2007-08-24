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
   import com.tobydietrich.soundeditor.utils.PlayPosition;
   import com.tobydietrich.soundeditor.utils.PlayState;
   import com.tobydietrich.soundeditor.utils.PlayableEvent;
    
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Timer;

   public class SoundModel extends EventDispatcher implements IPlayableModel
   {
      private var TIMER_INTERVAL:int = 10;

      private var myTimer:Timer;

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
         volume = 1.0;
         myTimer = new Timer(TIMER_INTERVAL);
         myTimer.addEventListener("timer", eTimerEvent);

         stop();
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
         return (playing) ? soundChannel.leftPeak : 0;
      }

      public function get rightPeak():Number {
         return (playing) ? soundChannel.rightPeak : 0;
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
         return (playing) ? soundChannel.position : myPausePosition;
      }

      /* this is the most important function */
      public function set position(newPosition:int):void {
         if(playing) {
            soundChannel.stop();
            mySoundChannel = null;
            myTimer.stop();
         }
         myPausePosition = newPosition;
         dispatchEvent(new PlayableEvent(PlayableEvent.CHANGE));
      }

      public function play():void {
         if(!playing) {
            mySoundChannel = sound.play(position, 0, new SoundTransform(volume));
            myTimer.start();
            mySoundChannel.addEventListener(Event.SOUND_COMPLETE, eComplete);
            dispatchEvent(new PlayableEvent(PlayableEvent.CHANGE));
         }
      }

      /* fraction overrides */
      public function get fractionComplete():Number {
         return position / length;
      }

      public function set fractionComplete(fraction:Number):void {
         position = fraction * length;
      }

      // friendly functions
      public function stop():void {
         position = 0;
      }

      public function rewindAll():void {
         position = 0;
      }

      public function forwardAll():void {
         position = length;
      }

      public function pause():void {
         //  this looks silly
         position = position;
      }

      public function get playState():int {
         return (soundChannel == null) ? PlayState.PAUSED : PlayState.PLAYING;
      }

      public function get playing():Boolean {
         return playState == PlayState.PLAYING;
      }

      public function get stopped():Boolean {
         return !playing && atEnd;
      }

      public function get paused():Boolean {
         return !playing && !atEnd;
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

      public function get atStart():Boolean {
         return playPosition == PlayPosition.AT_START;
      }

      public function get atEnd():Boolean {
         return playPosition == PlayPosition.AT_END;
      }

      private function eComplete(event:Event):void {
         forwardAll();
      }

      private function eTimerEvent(event:TimerEvent):void {
         dispatchEvent(new PlayableEvent(PlayableEvent.PROGRESS));
      }
      public function ping():void {
         dispatchEvent(new PlayableEvent(PlayableEvent.CHANGE));
      }
   }
}