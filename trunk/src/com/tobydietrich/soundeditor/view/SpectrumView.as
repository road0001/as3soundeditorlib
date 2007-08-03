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
 * The spectrum graph
 */
package com.tobydietrich.soundeditor.view
{  
   import flash.display.Sprite;
   import com.tobydietrich.soundeditor.model.SpectrumModel;
   import com.tobydietrich.soundeditor.utils.PlayableEvent;

   public class SpectrumView extends Sprite
	{
		
		private var mySpectrumModel:SpectrumModel;
		
		public function SpectrumView(spectrumModel:SpectrumModel) 
		{
			mySpectrumModel = spectrumModel;
			spectrumModel.addEventListener(PlayableEvent.PROGRESS, eProgress);
			
			var midline:Sprite = new Sprite();
			midline.x = 0;
			midline.y = SoundEditorView.SPECTRUM_HEIGHT/2;
			midline.graphics.beginFill(SoundEditorView.FILL_COLOR);
			midline.graphics.drawRect(0, 0, SoundEditorView.SPECTRUM_WIDTH, 1);
			midline.graphics.endFill();
			addChild(midline);
			
		}
		
		private function get spectrumModel():SpectrumModel {
			return mySpectrumModel;
		}
		
		public function eProgress(event:PlayableEvent):void {
			addTime(spectrumModel.getLeftPeak(event.time), spectrumModel.getRightPeak(event.time), event.time/ spectrumModel.soundModel.length);
		}
		public function addTime(leftPeak:Number, rightPeak:Number, fractionComplete:Number):void {
			var myX:int = fractionComplete * SoundEditorView.SPECTRUM_WIDTH;
			var right:Sprite = new Sprite();
			right.x = myX;
			right.y = SoundEditorView.SPECTRUM_HEIGHT/2;
			right.graphics.beginFill(SoundEditorView.FILL_COLOR);
			right.graphics.drawRect(0, 0, 1, rightPeak * SoundEditorView.SPECTRUM_HEIGHT/2);
			right.graphics.endFill();
			addChild(right);
			var left:Sprite = new Sprite();
			left.x = myX;
			left.y = SoundEditorView.SPECTRUM_HEIGHT/2-leftPeak * 
			 SoundEditorView.SPECTRUM_HEIGHT/2;
			left.graphics.beginFill(SoundEditorView.FILL_COLOR);
			left.graphics.drawRect(0, 0, 1, leftPeak * SoundEditorView.SPECTRUM_HEIGHT/2);
			left.graphics.endFill();
			addChild(left);
		}
	}
}