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
	import com.tobydietrich.soundeditor.controller.MusicController;
	import com.tobydietrich.soundeditor.model.PlayableModelEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class CursorView extends Sprite
	{
		private var myMusicController:MusicController;
		private var cursorSprite:Sprite;
		public function CursorView(musicController:MusicController)
		{
			myMusicController = musicController;
			myMusicController.addEventListener(PlayableModelEvent.PROGRESS, 
			 eUpdate);
			myMusicController.soundModel.addEventListener(PlayableModelEvent.CHANGE,
			 eUpdate);
		  graphics.beginFill(0xFFFFFF, 0.1); // XXX
	     graphics.drawRect(0, 0, MusicView.SPECTRUM_WIDTH, MusicView.SPECTRUM_HEIGHT);
	     graphics.endFill();
	     addEventListener(MouseEvent.CLICK, eClick);
	     cursorSprite = new Sprite();
         cursorSprite.graphics.beginFill(MusicView.CURSOR_COLOR);
         cursorSprite.graphics.drawRect(0,0,1,MusicView.SPECTRUM_HEIGHT);
         cursorSprite.graphics.endFill();
         addChild(cursorSprite);
		}
		
		private function eUpdate(event:PlayableModelEvent):void {
			cursorSprite.x = MusicView.SPECTRUM_WIDTH * 
			  myMusicController.soundModel.position 
			  / myMusicController.soundModel.length;
		}
		
		private function eClick(event:MouseEvent):void {
		   var playing:Boolean = myMusicController.soundModel.playing;
		   myMusicController.soundModel.fractionComplete = 
		     event.localX / MusicView.SPECTRUM_WIDTH;
		   if(playing) {
		      myMusicController.soundModel.play();
		   }
		}
	}
}