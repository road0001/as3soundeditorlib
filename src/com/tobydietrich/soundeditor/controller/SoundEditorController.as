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
   import com.tobydietrich.soundeditor.utils.CuePointEvent;
   import com.tobydietrich.soundeditor.utils.PlayableEvent;
   import com.tobydietrich.soundeditor.utils.SpectrumEvent;
   
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;

   public class SoundEditorController extends EventDispatcher implements IMediaController {
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

      /* Constructor */
      public function SoundEditorController(sndURL:String, cueURL:String) {
         //loaders
         myCueLoaderModel = new XMLLoaderModel("cue", cueURL);
         myCueLoaderModel.addEventListener(Event.COMPLETE, 
	         function eCueLoaded(event:Event):void {
		         myCuePointModel = new CuePointModel(event.target.xml);
		         cuePointModel.addEventListener(CuePointEvent.SELECT_NEW, function eSelectNew(event:CuePointEvent):void {
		         	dispatchEvent(new CuePointEvent(CuePointEvent.SELECT_NEW));
		         	dispatchEvent(new PlayableEvent(PlayableEvent.CHANGE));
		         });
		         cuePointModel.addEventListener(CuePointEvent.UPDATE, function eChange(event:CuePointEvent):void {
		         	dispatchEvent(new CuePointEvent(CuePointEvent.UPDATE));
		         });
		         //trace("loaded cue");
		         check(event);
	      	 }
      	 );
         mySoundLoaderModel = new SoundLoaderModel("mp3", sndURL);
         mySoundLoaderModel.addEventListener(Event.COMPLETE, 
	         function eSoundLoaded(event:Event):void {
		         mySoundModel = new SoundModel(event.target.sound);
		         soundModel.addEventListener(PlayableEvent.PROGRESS, function eProgress(event:PlayableEvent):void {
		         	dispatchEvent(new PlayableEvent(PlayableEvent.PROGRESS));
		         });
		         soundModel.addEventListener(PlayableEvent.CHANGE, function eChange(event:PlayableEvent):void {
		         	dispatchEvent(new PlayableEvent(PlayableEvent.CHANGE));
		         });
		         //trace("loaded sound");
		         check(event);
      	 	 }
      	 );
         mySpectrumSoundLoaderModel = new SoundLoaderModel("mp3 for spectrum", sndURL);
         mySpectrumSoundLoaderModel.addEventListener(Event.COMPLETE, 
	         function eSpectrumSoundLoaded(event:Event):void {
		         mySpectrumSoundModel = new SoundModel(event.target.sound);
		         /* Don't think I need this */
		         /*
		         spectrumSoundModel.addEventListener(PlayableEvent.PROGRESS, function eProgress(event:PlayableEvent):void {
		         	dispatchEvent(new Event(PlayableEvent.PROGRESS));
		         });
		         spectrumSoundModel.addEventListener(PlayableEvent.CHANGE, function eChange(event:PlayableEvent):void {
		         	dispatchEvent(new Event(PlayableEvent.CHANGE));
		         });
		         */
		         mySpectrumModel = new SpectrumModel(mySpectrumSoundModel);
		         spectrumModel.addEventListener(SpectrumEvent.PROGRESS, function eProgress(event:SpectrumEvent):void {
		         	dispatchEvent(new SpectrumEvent(SpectrumEvent.PROGRESS, false, false, event.time));
		         });
		         var t:Timer = new Timer(10000);
		         t.addEventListener(TimerEvent.TIMER, reportSpectrum);
            	 t.start();
            	 mySpectrumSoundModel.addEventListener(Event.SOUND_COMPLETE, reportSpectrum);
            	 
		         //trace("loaded spectrum sound");
		         check(event);
	         }
         );
         

      }
      
      private function reportSpectrum(event:Event):void {
 	 	//trace("reporting spectrum");
 	 	//trace(spectrumModel.spectrumModelXML); 
 	 }

      private function check(event:Event):void {
         if(myCuePointModel != null && mySoundModel != null
         && mySpectrumSoundModel != null) {
         	 // IMediaController functionality
	         soundModel.play(false);
	         soundModel.addEventListener(PlayableEvent.PROGRESS, function eProgress(event:PlayableEvent):void {
		     	dispatchEvent(new PlayableEvent(PlayableEvent.PROGRESS));
		     });
	      	 soundModel.addEventListener(PlayableEvent.CHANGE, function eChange(event:PlayableEvent):void {
	      	 	dispatchEvent(new PlayableEvent(PlayableEvent.CHANGE));
	      	 });
	         soundModel.ping();
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
      private function get spectrumModel():SpectrumModel {
         return mySpectrumModel;
      }
      private function get soundModel():SoundModel {
         return mySoundModel;
      }
      private function get cuePointModel():CuePointModel {
         return myCuePointModel;
      }
      public function get cuePointList():XMLList {
      	return cuePointModel.xml.CuePoint;
      }
      public function get numCuePoints():int {
      	return cuePointModel.numCuePoints;
      }
      public function get selectedCuePoint():XML {
      	return cuePointModel.selectedCuePoint;
      }
      public function set selectedCuePoint(s:XML):void {
      	//trace("selected a cue point in the controller " + s.toXMLString());
      	cuePointModel.selectedCuePoint = s;
      	position = s.Time[0];
      }
      public function get soundLength():int {
      	return soundModel.length;
      }
      public function getPeak(time:int):XML {
      	return spectrumModel.getPeak(time);
      }
      
      // IMediaController
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
      
   }
}