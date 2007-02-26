
package com.tobydietrich.soundeditor.sound
{
   import com.tobydietrich.soundeditor.player.*;
   import com.tobydietrich.soundeditor.utils.*;
   import flash.display.Sprite;
   import com.tobydietrich.soundeditor.SpectrumApp;

   public class SpectrumPlayer extends Sprite implements Playable
   {
      // enum listing the play state
      protected var myPlayState:int = PlayState.STOPPED;

      // enum listing the play positioon
      protected var myPlayPosition:int = PlayPosition.AT_BEGINNING;

      private var cursorSprite:Sprite = new Sprite();
      
      private var spectrumGraph:SpectrumGraph;
      
      private var CURSOR_COLOR:uint = 0xFF0000;
      
      public function SpectrumPlayer(x:int, y:int, snd_URL:String) {
      	 spectrumGraph = new SpectrumGraph(0, 0, snd_URL);
         this.x = x;
         this.y = y;

         cursorSprite.graphics.beginFill(CURSOR_COLOR);
         cursorSprite.graphics.drawRect(0,50,1,100);
         cursorSprite.graphics.endFill();
         
         addChild(cursorSprite);
         addChild(spectrumGraph);
      }

      public function updateCursor(fractionComplete:Number):void {
         cursorSprite.x = fractionComplete*maxCursor;
      }

      public function get maxCursor():Number {
         return spectrumGraph.width;
      }

      public function get fractionComplete():Number
      {
         return cursorSprite.x/maxCursor;
      }

      public function set fractionComplete(fraction:Number):void {
         cursorSprite.x = maxCursor * fraction;
      }

      public function stop():void
      {
         myPlayState = PlayState.STOPPED;
      }

      public function rewindAll():void
      {
         stop();
      }

      public function pause():void
      {
         myPlayState = PlayState.PAUSED;
         if(cursorSprite.x==0) {
            myPlayPosition = PlayPosition.AT_BEGINNING;
         } else if(cursorSprite.x==maxCursor) {
            myPlayPosition = PlayPosition.AT_END;
         } else {
            myPlayPosition = PlayPosition.IN_MIDDLE;
         }
      }

      public function play():void
      {
         if(myPlayState == PlayState.PLAYING) {
            return;
         }
         if(myPlayState==PlayState.STOPPED) {
            rewindAll();
         }
         myPlayState = PlayState.PLAYING;
         myPlayPosition = PlayPosition.IN_MIDDLE;
      }

      public function forwardAll():void
      {
         myPlayState = PlayState.STOPPED;
         myPlayPosition = PlayPosition.AT_END;
         cursorSprite.x = maxCursor;
      }

      public function synchronize(p:Playable):void {
         p.fractionComplete = fractionComplete;
      }
      
	    public function get stopped():Boolean
		{
			return myPlayState == PlayState.STOPPED;
		}
		
		public function get atBeginning():Boolean
		{
			return myPlayPosition == PlayPosition.AT_BEGINNING;
		}
		
		public function get atEnd():Boolean
		{
			return myPlayPosition== PlayPosition.AT_END;
		}
		
		public function get paused():Boolean
		{
			return myPlayState == PlayState.PAUSED;
		}
		
		public function get playing():Boolean
		{
			return myPlayState == PlayState.PLAYING;
		}
		
		public function get playState():int {
			return myPlayState;
		}
		
		public function get playPosition():int {
			return myPlayPosition;
		}
   }
}