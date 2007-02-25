package com.audeto.as3soundeditorlib
{
   import com.audeto.as3soundeditorlib.sound.*;
   import com.audeto.as3soundeditorlib.player.*;
   import com.audeto.as3soundeditorlib.utils.*;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.display.Sprite;

   public class SpectrumApp extends Sprite implements Playable, SoundClient
   {
      // TODO
      private var positionTimer:Timer;

      // the timer delay
      static private var timerInterval:Number = 50;

      // spectrumPlayer
      private var spectrumPlayer:SpectrumPlayer;

      // the sound loader
      private var sndLoader:LoaderSprite = new LoaderSprite("MP3 File");

      // the swatch loader
      private var cueLoader:LoaderSprite = new LoaderSprite("Cue XML");

      // the window that displays the load progress
      private var loaderWindow:Sprite = new Sprite();

      // the player control
      private var playerControl:PlayerControl =
      new PlayerControl(this as Playable);

      // stores the sound file
      private var mySound:SoundTrack;

      // stores the cue points
      private var myCuePoint:CueXML;

      /**
       * Constructor
       */
      public function SpectrumApp(snd_URL:String, cue_URL:String) {
         // start creating the SpectrumGraph.
         // Right now we need to play the whole thing
         spectrumPlayer = new SpectrumPlayer(10, 10, snd_URL);
         addChild(spectrumPlayer);
          
         // stores the sound file
         mySound = new SoundTrack(this, snd_URL);

         // stores the cue file
         myCuePoint = new CueXML(this, cue_URL);

         addChild(loaderWindow);
         loaderWindow.x = 10;
         loaderWindow.y = 200;
         loaderWindow.addChild(sndLoader);
         loaderWindow.addChild(cueLoader);
         cueLoader.y = 50;
         addChild(playerControl);
         playerControl.x = 200;
         playerControl.y = 200;
      }

      /***
       * private functions
       */
      private function positionTimerHandler(event:TimerEvent):void {
         spectrumPlayer.updateCursor(mySound.position/mySound.length);
      }

      /**
       * public functions (interface)
       */

      public function get stopped():Boolean
      {
         return mySound.stopped;
      }

      public function rewindAll():void
      {
         mySound.rewindAll();
         spectrumPlayer.rewindAll();
      }

      public function play():void
      {
         if(playState == PlayState.PLAYING) {
            return;
         }
         if(playState==PlayState.STOPPED) {
            rewindAll();
         }
         mySound.synchronize(spectrumPlayer);
         mySound.play();
         spectrumPlayer.play();
         positionTimer.start();
      }

      public function get atBeginning():Boolean
      {
         return mySound.atBeginning;
      }

      public function synchronize(p:Playable):void
      {
         p.fractionComplete = this.fractionComplete;
      }

      public function get atEnd():Boolean
      {
         return mySound.atEnd;
      }

      public function forwardAll():void
      {
         mySound.forwardAll();
         spectrumPlayer.forwardAll();
      }

      public function stop():void
      {
         positionTimer.stop();
         mySound.stop();
         spectrumPlayer.stop();
      }

      public function get fractionComplete():Number
      {
         return mySound.fractionComplete;
      }

      public function set fractionComplete(x:Number):void
      {
         mySound.fractionComplete = x;
         spectrumPlayer.fractionComplete = x;
      }

      public function get paused():Boolean
      {
         return mySound.paused;
      }

      public function get playing():Boolean
      {
         return mySound.playing;
      }

      public function pause():void
      {
         mySound.pause();
         mySound.synchronize(spectrumPlayer);
      }

      public function set sndLoaderProgress(fraction:Number):void
      {
         sndLoader.fractionComplete = fraction;

      }

      public function get sndLoaderProgress():Number
      {
         return sndLoader.fractionComplete;
      }

      public function checkForCompletion():void
      {
         if(mySound.isLoaded) {
            sndLoader.complete = true;
         }
         if(myCuePoint.isLoaded) {
            cueLoader.complete = true;
         }
         if(mySound.isLoaded && myCuePoint.isLoaded) {
            positionTimer = new Timer(timerInterval);
            positionTimer.addEventListener(TimerEvent.TIMER, positionTimerHandler);
            play();
         }
      }

      public function set cueLoaderProgress(fraction:Number):void
      {
         cueLoader.fractionComplete = fraction;
      }

      public function get cueLoaderProgress():Number
      {
         return cueLoader.fractionComplete;
      }
      
      public function get playState():int {
         return mySound.playState;
      }

      public function get playPosition():int {
         return mySound.playPosition;
      }

   }
}