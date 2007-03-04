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
   import com.tobydietrich.soundeditor.controller.SpectrumController;
   
   import flash.display.Sprite;
   import flash.events.*;
   import com.tobydietrich.soundeditor.model.*;

   public class SpectrumView extends Sprite
	{
		private var mySpectrumController:SpectrumController;
		
		public function SpectrumView(spectrumController:SpectrumController) 
		{
			mySpectrumController = spectrumController;
			mySpectrumController.spectrumModel.addEventListener(SpectrumModelEvent.ADD_TIME, 
			 eAddTime);
			var midline:Sprite = new Sprite();
			midline.x = 0;
			midline.y = MusicView.SPECTRUM_HEIGHT/2;
			midline.graphics.beginFill(MusicView.FILL_COLOR);
			midline.graphics.drawRect(0, 0, MusicView.SPECTRUM_WIDTH, 1);
			midline.graphics.endFill();
			addChild(midline);
		}
		
		private function eAddTime(event:SpectrumModelEvent):void {
			var myX:int = event.time / mySpectrumController.musicController.soundModel.length * MusicView.SPECTRUM_WIDTH;
			var right:Sprite = new Sprite();
			right.x = myX;
			right.y = MusicView.SPECTRUM_HEIGHT/2;
			right.graphics.beginFill(MusicView.FILL_COLOR);
			right.graphics.drawRect(0, 0, 1, 
			 mySpectrumController.spectrumModel.getRightPeak(event.time) * MusicView.SPECTRUM_HEIGHT/2);
			right.graphics.endFill();
			addChild(right);
			var left:Sprite = new Sprite();
			left.x = myX;
			left.y = MusicView.SPECTRUM_HEIGHT/2-mySpectrumController.spectrumModel.getLeftPeak(event.time) * 
			 MusicView.SPECTRUM_HEIGHT/2;
			left.graphics.beginFill(MusicView.FILL_COLOR);
			left.graphics.drawRect(0, 0, 1, 
			 mySpectrumController.spectrumModel.getLeftPeak(event.time) * MusicView.SPECTRUM_HEIGHT/2);
			left.graphics.endFill();
			addChild(left);
		}
	}
}