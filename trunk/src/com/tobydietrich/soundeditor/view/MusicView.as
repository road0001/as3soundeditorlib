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
package com.tobydietrich.soundeditor.view
{
	import flash.display.Sprite;
	import com.tobydietrich.soundeditor.controller.*;

	public class MusicView extends Sprite
   {
   	static public var FILL_COLOR:uint = 0x00FF00;
	   static public var SPECTRUM_HEIGHT:int = 200;
      static public var CURSOR_COLOR:uint = 0xFF0000;
      static public var SPECTRUM_WIDTH:int = 500;
   

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