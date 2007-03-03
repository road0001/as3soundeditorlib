package com.tobydietrich.soundeditor.view
{
	import flash.display.Sprite;
	import com.tobydietrich.soundeditor.controller.*;

	public class MusicView extends Sprite
   {
   	  static public var FILL_COLOR:uint = 0x00FF00;
	  static public var CHANNEL_HEIGHT:int = 100;
      static public var CURSOR_COLOR:uint = 0xFF0000;
      static public var SOUND_WIDTH:int = 2000;
   

      private var myCueController:CueController;
      private var myMusicController:MusicController;
      private var mySpectrumController:SpectrumController;
      
            private var cursorView:CursorView;
      private var spectrumView:SpectrumView;
      private var cueView:CueView;
      
      public function MusicView(cueController:CueController, 
       musicController:MusicController, 
       spectrumController:SpectrumController, x:int, y:int) {
       	      	 myCueController = cueController;
       	      	       	 myMusicController = musicController;
      	 mySpectrumController = spectrumController;
         this.x = x;
         this.y = y;
         spectrumView = new SpectrumView(mySpectrumController);
         addChild(spectrumView);
         cursorView = new CursorView(myMusicController);
		 addChild(cursorView);
		 cueView = new CueView(myCueController);
		 addChild(cueView);
      }
   }
}