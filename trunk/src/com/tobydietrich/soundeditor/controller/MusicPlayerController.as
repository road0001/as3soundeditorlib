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
   import com.tobydietrich.soundeditor.utils.PlayableEvent;
   import com.tobydietrich.soundeditor.view.ControlButtonsView;
   import com.tobydietrich.soundeditor.view.CursorView;

   import flash.events.EventDispatcher;

   public class MusicPlayerController extends EventDispatcher implements IMediaController
   {
      private var mySoundModel:SoundModel;
      private var myControlButtonsView:ControlButtonsView;
      private var myCursorView:CursorView;

      public function MusicPlayerController(soundModel:SoundModel) {
         mySoundModel = soundModel;

         soundModel.pause();
         soundModel.addEventListener(PlayableEvent.CHANGE, 
	         function eUpdate(event:PlayableEvent):void {
		         if(controlButtonsView != null) {
		            controlButtonsView.paused(soundModel.paused);
		            controlButtonsView.forwardButtonEnabled(!soundModel.atEnd);
		            controlButtonsView.rewindButtonEnabled(!soundModel.atStart);
		         }
		
		         dispatchEvent(new PlayableEvent(PlayableEvent.CHANGE));
		      }
	      );
         soundModel.addEventListener(PlayableEvent.PROGRESS, 
	         function eProgress(event:PlayableEvent):void {
	         	dispatchEvent(new PlayableEvent(PlayableEvent.PROGRESS));
	      	 }
      	 );
         soundModel.ping();
      }
      private function get soundModel():SoundModel {
         return mySoundModel;
      }

      public function set controlButtonsView(c:ControlButtonsView):void {
         myControlButtonsView = c;
      }
      public function get controlButtonsView():ControlButtonsView {
         return myControlButtonsView;
      }
      public function play():void {
         if(soundModel.playing) {
            soundModel.pause();
         } else {
            soundModel.play();
         }
      }

      public function rewindAll():void {
         soundModel.rewindAll();
      }

      public function forwardAll():void {
         soundModel.forwardAll();
      }

      public function get fractionComplete():Number {
         return soundModel.fractionComplete;
      }

      public function set fractionComplete(fraction:Number):void {
         var playing:Boolean = soundModel.playing;
         soundModel.fractionComplete = fraction;
         if(playing) {
            soundModel.play();
         }
      }

      public function get position():Number {
         return soundModel.position;
      }
   }
}