/**
 * This feeds data into a SpectrumModel. There is no user interaction when 
 * building the spectrumModel, so it doesn't interact with any view.
 */
 package com.tobydietrich.soundeditor.controller
{
	import com.tobydietrich.soundeditor.model.*;
	
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	
	public class SpectrumController extends EventDispatcher
	{
		private var myMusicController:MusicController;
		private var mySpectrumModel:SpectrumModel;
	    private var timer:Timer;
	    private var TIMER_INTERVAL:int = 10;
		
		public function SpectrumController(musicController:MusicController, 
		 spectrumModel:SpectrumModel) {
		 myMusicController = musicController;
		 mySpectrumModel = spectrumModel;
		 myMusicController.volume = 0.01;
         myMusicController.play();
         myMusicController.soundModel.addEventListener(Event.SOUND_COMPLETE, 
            eComplete);
         timer = new Timer(TIMER_INTERVAL);
         timer.addEventListener(TimerEvent.TIMER, eTimer);
         timer.start();
		}
		
		public function get musicController():MusicController {
			return myMusicController;
		}
		
		public function get spectrumModel():SpectrumModel {
			return mySpectrumModel;
		}
		
		private function eComplete(event:Event):void {
			timer.stop();
		}
		
		private function eTimer(event:TimerEvent):void {
			mySpectrumModel.addPeak(myMusicController.soundModel.leftPeak/myMusicController.volume, 
			   myMusicController.soundModel.rightPeak/myMusicController.volume, 
			   myMusicController.soundModel.position);
		}
	}
}