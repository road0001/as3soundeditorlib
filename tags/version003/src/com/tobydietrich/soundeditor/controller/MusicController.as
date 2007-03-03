/***
 * A controller for the music
 */
  package com.tobydietrich.soundeditor.controller
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import com.tobydietrich.soundeditor.model.*;
	import flash.events.*;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	public class MusicController extends EventDispatcher implements IPlayableController
	{
		static private var TIMER_DELAY:int = 10;
		
		private var mySoundModel:SoundModel;
		
		private var myVolume:Number = 1.0;
		
		private var timer:Timer;
		
		public function MusicController(soundModel:SoundModel) {
		   mySoundModel = soundModel;
		}
		
		public function get soundModel():SoundModel {
			return mySoundModel;
		}
		
	  public function set fractionComplete(fraction:Number):void {
         if(mySoundModel.soundChannel != null) {
            mySoundModel.soundChannel.stop();
         }
         mySoundModel.position = fraction*mySoundModel.length;
      }

      public function stop():void
      {
         if(mySoundModel.soundChannel != null) {
            mySoundModel.soundChannel.stop();
         }
         mySoundModel.playState = PlayState.STOPPED;
      }

      public function rewindAll():void
      {
         // maybe start playing again??
         stop();
      }

      public function pause():void
      {
      	 mySoundModel.position = mySoundModel.soundChannel.position;
      	 if(mySoundModel.soundChannel != null) {
            mySoundModel.soundChannel.stop();
         }
         mySoundModel.playState = PlayState.PAUSED;
         if(mySoundModel.position==0) {
            mySoundModel.playPosition = PlayPosition.AT_BEGINNING;
         } else if(mySoundModel.position==mySoundModel.length) {
            mySoundModel.playPosition = PlayPosition.AT_END;
         } else {
            mySoundModel.playPosition = PlayPosition.IN_MIDDLE;
         }

      }

      public function play():void
      {
         if(mySoundModel.playState == PlayState.PLAYING) {
            return;
         }
         if(mySoundModel.playState==PlayState.STOPPED) {
            rewindAll();
         }
         mySoundModel.soundChannel = mySoundModel.sound.play(mySoundModel.position, 0, new SoundTransform(myVolume));
         mySoundModel.playState = PlayState.PLAYING;
         mySoundModel.playPosition = PlayPosition.IN_MIDDLE;
         timer = new Timer(TIMER_DELAY);
         timer.addEventListener(TimerEvent.TIMER, eTimer);
         timer.start();
         mySoundModel.soundChannel.addEventListener(Event.SOUND_COMPLETE, eComplete);
      }

      public function forwardAll():void
      {
         mySoundModel.position = mySoundModel.length;
         mySoundModel.playState = PlayState.STOPPED;
         mySoundModel.playPosition = PlayPosition.AT_END;
         if(mySoundModel.soundChannel != null) {
            mySoundModel.soundChannel.stop();
         }
      }
      
      private function eComplete(event:Event):void {
      	// we are at the end, we are stopped, etc.
			forwardAll();
			timer.stop();
			dispatchEvent(event);
      }
      
      private function eTimer(event:TimerEvent):void {
      	dispatchEvent(event);
      }
      
      public function get volume():Number {
      	return myVolume;
      }
      
      public function set volume(newVolume:Number):void {
      	myVolume = newVolume;
      }
	}
}