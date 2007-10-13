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
   import com.tobydietrich.soundeditor.controller.ISpectrumSoundController;
   import com.tobydietrich.soundeditor.utils.SoundEditorEvent;
   
   import flash.display.Sprite;

   public class SpectrumView extends Sprite
   {

      private var mySpectrumSoundController:ISpectrumSoundController;

      public function SpectrumView(spectrumSoundController:ISpectrumSoundController)
      {
         mySpectrumSoundController = spectrumSoundController;
         spectrumSoundController.addEventListener(SoundEditorEvent.SPECTRUM_PROGRESS, function eProgress(event:SoundEditorEvent):void {
	      	var peak:XML = event.data;
	      	if(peak != null) {
	      		addTime(peak.@left, peak.@right, peak.@position);
	      	}
	      });
         	
         graphics.beginFill(0xFFFFFF, 0.1); // XXX
         graphics.drawRect(0, 0, SoundEditorView.SPECTRUM_WIDTH, SoundEditorView.SPECTRUM_HEIGHT);
         graphics.endFill();

         var midline:Sprite = new Sprite();
         midline.x = 0;
         midline.y = SoundEditorView.SPECTRUM_HEIGHT/2;
         midline.graphics.beginFill(SoundEditorView.FILL_COLOR);
         midline.graphics.drawRect(0, 0, SoundEditorView.SPECTRUM_WIDTH, 1);
         midline.graphics.endFill();
         addChild(midline);
         	
      }
      
      private function addTime(leftPeak:Number, rightPeak:Number, time:Number):void {
      	 var fractionComplete:Number = time/ spectrumSoundController.soundLength;
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
      private function get spectrumSoundController():ISpectrumSoundController {
      	return mySpectrumSoundController;
      }
   }
}