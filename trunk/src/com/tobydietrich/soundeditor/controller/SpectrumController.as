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
 * This feeds data into a SpectrumModel. There is no user interaction when 
 * building the spectrumModel, so it doesn't interact with any view.
 */
 package com.tobydietrich.soundeditor.controller
{
	import com.tobydietrich.soundeditor.model.*;
	
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	
	public class SpectrumController extends EventDispatcher
	{ 
		private var myMusicController:MusicController;
		private var mySpectrumModel:SpectrumModel;

		public function SpectrumController(musicController:MusicController, 
		 spectrumModel:SpectrumModel) {
		 myMusicController = musicController;
		 mySpectrumModel = spectrumModel;
		 myMusicController.soundModel.volume = 0.01;
         myMusicController.soundModel.play();
         myMusicController.soundModel.addEventListener(Event.SOUND_COMPLETE, 
            eComplete);
         myMusicController.addEventListener(PlayableModelEvent.PROGRESS, eProgress);
		}
		
		public function get musicController():MusicController {
			return myMusicController;
		}
		
		public function get spectrumModel():SpectrumModel {
			return mySpectrumModel;
		}
		
		private function eComplete(event:Event):void {
		}
		
		private function eProgress(event:PlayableModelEvent):void {
			mySpectrumModel.addPeak(
			   myMusicController.soundModel.leftPeak / myMusicController.soundModel.volume, 
			   myMusicController.soundModel.rightPeak/ myMusicController.soundModel.volume, 
			   myMusicController.soundModel.position);
		}
	}
}