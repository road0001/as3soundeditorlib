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
/***
 * A controller for the music
 */
  package com.tobydietrich.soundeditor.controller
{

	import com.tobydietrich.soundeditor.model.SoundModel;
	import com.tobydietrich.soundeditor.model.PlayableModelEvent;
		import flash.events.EventDispatcher;
		import flash.events.MouseEvent;
		import com.tobydietrich.soundeditor.view.*;

	public class PlayerController extends EventDispatcher
	{	
		private var mySoundModel:SoundModel;
		private var myControlButtonsView:ControlButtonsView;
		private var myCursorView:CursorView;

		public function PlayerController(soundModel:SoundModel) {
		   mySoundModel = soundModel;
		   
		   soundModel.pause();
      		soundModel.addEventListener(PlayableModelEvent.CHANGE, eUpdate);
      		soundModel.ping();
		}
		public function get soundModel():SoundModel {
			return mySoundModel;
		}
		
		public function registerControlButtonsView(controlButtonsView:ControlButtonsView):void {
			
		   myControlButtonsView = controlButtonsView;
		}
		public function get controlButtonsView():ControlButtonsView {
			return myControlButtonsView;
		}
		public function ePlay(event:MouseEvent):void {
			if(soundModel.playing) {
				soundModel.pause();
			} else {
			    soundModel.play();
			}
		}
		
		public function eRewind(event:MouseEvent):void {
			soundModel.rewindAll();
		}
		
		public function eForward(event:MouseEvent):void {
			soundModel.forwardAll();
		}
		
		private function eCursor(event:MouseEvent):void {
		   var playing:Boolean = soundModel.playing;
		   soundModel.fractionComplete = 
		     event.localX / SoundEditorView.SPECTRUM_WIDTH;
		   if(playing) {
		      soundModel.play();
		   }
		}
		
		public function eUpdate(event:PlayableModelEvent):void {
			if(controlButtonsView != null) {
		   controlButtonsView.playButtonEnabled(!soundModel.playing);
		   controlButtonsView.pauseButtonEnabled(soundModel.playing);
		   controlButtonsView.forwardButtonEnabled(!soundModel.atEnd);
		   controlButtonsView.rewindButtonEnabled(!soundModel.atStart);
		 }
		}
	}
}