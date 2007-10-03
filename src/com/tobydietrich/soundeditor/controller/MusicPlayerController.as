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
   
   import flash.events.EventDispatcher;

   public class MusicPlayerController extends EventDispatcher implements IMediaController
   {
      private var mySoundModel:SoundModel;

      public function MusicPlayerController(soundModel:SoundModel) {
         mySoundModel = soundModel;

         soundModel.play(false);
         soundModel.addEventListener(PlayableEvent.PROGRESS, function eProgress(event:PlayableEvent):void {
	     	dispatchEvent(new PlayableEvent(PlayableEvent.PROGRESS));
	     });
      	 soundModel.addEventListener(PlayableEvent.CHANGE, function eChange(event:PlayableEvent):void {
      	 	dispatchEvent(new PlayableEvent(PlayableEvent.CHANGE));
      	 });
         soundModel.ping();
      }
      private function get soundModel():SoundModel {
         return mySoundModel;
      }

      public function play(isPlayCommand:Boolean):void {
            soundModel.play(isPlayCommand);
      }
      public function togglePlay():void {
      	soundModel.play(!soundModel.playing);
      }

      public function rewindAll():void {
         soundModel.rewindAll();
      }

      public function forwardAll():void {
         soundModel.forwardAll();
      }

      public function get position():int {
         return soundModel.position;
      }

      public function set position(p:int):void {
         var playing:Boolean = soundModel.playing;
         soundModel.position = p;
         if(playing) {
            soundModel.play(true);
         }
      }

      public function get atEnd():Boolean {
      	return soundModel.atEnd;
      }
      public function get atStart():Boolean {
      	return soundModel.atStart;
      }
      public function get paused():Boolean {
      	return soundModel.paused;
      }
      public function get soundLength():int {
      	return soundModel.length;
      }
   }
}