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
			midline.y = MusicView.CHANNEL_HEIGHT;
			midline.graphics.beginFill(MusicView.FILL_COLOR);
			midline.graphics.drawRect(0, 0, MusicView.SOUND_WIDTH, 1);
			midline.graphics.endFill();
			addChild(midline);
		}
		
		private function eAddTime(event:SpectrumModelEvent):void {
			var myX:int = event.time / mySpectrumController.musicController.soundModel.length * MusicView.SOUND_WIDTH;
			var right:Sprite = new Sprite();
			right.x = myX;
			right.y = MusicView.CHANNEL_HEIGHT;
			right.graphics.beginFill(MusicView.FILL_COLOR);
			right.graphics.drawRect(0, 0, 1, 
			 mySpectrumController.spectrumModel.getRightPeak(event.time) * MusicView.CHANNEL_HEIGHT);
			right.graphics.endFill();
			addChild(right);
			var left:Sprite = new Sprite();
			left.x = myX;
			left.y = MusicView.CHANNEL_HEIGHT-mySpectrumController.spectrumModel.getLeftPeak(event.time) * 
			 MusicView.CHANNEL_HEIGHT;
			left.graphics.beginFill(MusicView.FILL_COLOR);
			left.graphics.drawRect(0, 0, 1, 
			 mySpectrumController.spectrumModel.getLeftPeak(event.time) * MusicView.CHANNEL_HEIGHT);
			left.graphics.endFill();
			addChild(left);
		}
	}
}