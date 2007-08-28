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
 * Synchronizes the player and the sound. Wraps the MusicPlayerController
 */
package com.tobydietrich.soundeditor.controller
{
   import com.tobydietrich.soundeditor.model.CuePointModel;
   import com.tobydietrich.soundeditor.model.ILoaderModel;
   import com.tobydietrich.soundeditor.model.SoundLoaderModel;
   import com.tobydietrich.soundeditor.model.SoundModel;
   import com.tobydietrich.soundeditor.model.SpectrumModel;
   import com.tobydietrich.soundeditor.model.XMLLoaderModel;

   import flash.events.Event;
   import flash.events.EventDispatcher;

   public class SoundEditorController extends EventDispatcher {
      // loaders
      private var myCueLoaderModel:XMLLoaderModel;
      // for the playhead
      private var mySoundLoaderModel:SoundLoaderModel;
      // to generate the spectrum
      private var mySpectrumSoundLoaderModel:SoundLoaderModel;

      // models

      private var myCuePointModel:CuePointModel;
      // for the playhead
      private var mySoundModel:SoundModel;
      // to generate the spectrum
      private var mySpectrumSoundModel:SoundModel;
      private var mySpectrumModel:SpectrumModel;

      // controllers
      private var myMusicPlayerController:MusicPlayerController;

      /* Constructor */
      public function SoundEditorController(sndURL:String, cueURL:String) {
         //loaders
         myCueLoaderModel = new XMLLoaderModel("cue", cueURL);
         myCueLoaderModel.addEventListener(Event.COMPLETE, eCueLoaded);
         mySoundLoaderModel = new SoundLoaderModel("mp3", sndURL);
         mySoundLoaderModel.addEventListener(Event.COMPLETE, eSoundLoaded);
         mySpectrumSoundLoaderModel = new SoundLoaderModel("mp3 for spectrum", sndURL);
         mySpectrumSoundLoaderModel.addEventListener(Event.COMPLETE, eSpectrumSoundLoaded);
      }

      private function eCueLoaded(event:Event):void {
         myCuePointModel = new CuePointModel(event.target.xml);
         trace("loaded cue");
         check(event);
      }

      private function eSoundLoaded(event:Event):void {
         mySoundModel = new SoundModel(event.target.sound);
         trace("loaded sound");
         check(event);
      }

      private function eSpectrumSoundLoaded(event:Event):void {
         mySpectrumSoundModel = new SoundModel(event.target.sound);
         trace("loaded spectrum sound");
         check(event);
      }

      private function check(event:Event):void {
         if(myCuePointModel != null && mySoundModel != null
         && mySpectrumSoundModel != null) {
         	myMusicPlayerController = new MusicPlayerController(mySoundModel);
            mySpectrumModel = new SpectrumModel(mySpectrumSoundModel);
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }

      public function get cueLoaderModel():ILoaderModel {
         return myCueLoaderModel;
      }
      public function get soundLoaderModel():SoundLoaderModel {
         return mySoundLoaderModel;
      }
      public function get spectrumSoundLoaderModel():SoundLoaderModel {
         return mySpectrumSoundLoaderModel;
      }
      public function get musicPlayerController():MusicPlayerController {
         return myMusicPlayerController;
      }
      public function get spectrumModel():SpectrumModel {
         return mySpectrumModel;
      }
      public function get soundModel():SoundModel {
         return mySoundModel;
      }
      public function get cuePointModel():CuePointModel {
         return myCuePointModel;
      }
   }
}