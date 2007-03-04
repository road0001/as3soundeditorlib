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
 * A rewind button
 */
package com.tobydietrich.soundeditor.view
{
	import com.tobydietrich.soundeditor.controller.MusicController;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.tobydietrich.soundeditor.model.PlayableModelEvent;

	public class RewindButtonView extends ButtonView
	{
		private var rewindButton:Sprite;
		
		public function RewindButtonView(musicController:MusicController) {
			super(musicController);
		   
		   rewindButton = new ButtonLabel('<<');
			addChildAt(rewindButton, 0);
			
			musicController.soundModel.addEventListener(PlayableModelEvent.CHANGE,
			 eChange);
			musicController.soundModel.ping();
			buttonSprite.addEventListener(MouseEvent.CLICK, eRewind);
		}
		
		private function eRewind(event:MouseEvent):void {
		   trace('pressed rewind');
			myMusicController.soundModel.rewindAll();
		   rewindButton.visible = !myMusicController.soundModel.atStart;
		}
		
		private function eChange(event:PlayableModelEvent):void {
		    rewindButton.visible = !myMusicController.soundModel.atStart;
		}
	}
}