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
		import flash.utils.Timer;
		import flash.events.EventDispatcher;
		import flash.events.TimerEvent;

	public class MusicController extends EventDispatcher
	{
	   private var TIMER_DELAY:int = 10;
	   
	   private var timer:Timer;
		
		private var mySoundModel:SoundModel;

		public function MusicController(soundModel:SoundModel) {
		   mySoundModel = soundModel;
		   mySoundModel.addEventListener(PlayableModelEvent.CHANGE, eChange);
		   timer = new Timer(TIMER_DELAY);
         timer.addEventListener(TimerEvent.TIMER, eTimer);
		}
		
		public function get soundModel():SoundModel {
			return mySoundModel;
		}
		
		private function eChange(event:PlayableModelEvent):void {
		   if(event.target.playing) {
            timer.start();
		   } else {
		      timer.stop();
		   }
		}
		
		private function eTimer(event:TimerEvent):void {
		   dispatchEvent(new PlayableModelEvent(PlayableModelEvent.PROGRESS));
		}
	}
}