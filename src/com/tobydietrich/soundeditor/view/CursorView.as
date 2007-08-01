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
	import com.tobydietrich.soundeditor.model.PlayableModelEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.tobydietrich.soundeditor.controller.PlayerController;

	public class CursorView extends Sprite
	{
		private var cursorSprite:Sprite;
		private var myPlayerController:PlayerController;
		
		public function CursorView(playerController:PlayerController)
		{
		myPlayerController = playerController;
		 graphics.beginFill(0xFFFFFF, 0.1); // XXX
	     graphics.drawRect(0, 0, SoundEditorView.SPECTRUM_WIDTH, SoundEditorView.SPECTRUM_HEIGHT);
	     graphics.endFill();
	     cursorSprite = new Sprite();
         cursorSprite.graphics.beginFill(SoundEditorView.CURSOR_COLOR);
         cursorSprite.graphics.drawRect(0,0,1,SoundEditorView.SPECTRUM_HEIGHT);
         cursorSprite.graphics.endFill();
         addChild(cursorSprite);
         
         playerController.soundModel.addEventListener(PlayableModelEvent.PROGRESS, eUpdate);
		}
		
		private function get playerController():PlayerController {
			return myPlayerController;
		}
		
		private function eUpdate(event:PlayableModelEvent):void {
			updateCursor(playerController.soundModel.fractionComplete);
		}
		
		private function updateCursor(fractionComplete:Number):void {
			cursorSprite.x = SoundEditorView.SPECTRUM_WIDTH * fractionComplete;
		}
		
	}
}