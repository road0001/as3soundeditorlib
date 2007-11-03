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

	import com.tobydietrich.soundeditor.controller.SoundEditorController;
	import com.tobydietrich.utils.TobyDietrichEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class CuePointView extends Sprite
	{
		private var mySoundEditorController:SoundEditorController;
		private var cuePointLayer:Sprite = new Sprite();
		
		public function CuePointView(soundEditorController:SoundEditorController) 
		{
			// cache the controller
			mySoundEditorController = soundEditorController;
			
			// create the bounding box
		 	graphics.beginFill(0xFFFFFF, 0.01); // XXX
         	graphics.drawRect(0, 0, SoundEditorView.SPECTRUM_WIDTH, SoundEditorView.SPECTRUM_HEIGHT);
         	graphics.endFill();
         	
         	// create the layer for cue points
         	addChild(cuePointLayer);
			
			
			// attach event listeners
			soundEditorController.addEventListener(TobyDietrichEvent.CUE_POINT_UPDATE, function eUpdate(event:TobyDietrichEvent):void {
				trace ("updating " + event.target);
			});
			
			soundEditorController.addEventListener(TobyDietrichEvent.CUE_POINT_SELECT_NEW, function eSelectNew(event:TobyDietrichEvent):void {
				//trace ("selecting new @ " + soundEditorController.selectedCuePoint.Time[0]);
			});
			
			// add the cue points
			addCuePoints(soundEditorController.cuePointList);
		}
		
		private function addCuePoints(cuePointList:XMLList):void {
			for each(var cuePoint:XML in cuePointList) {
				if(cuePoint.Type != null && cuePoint.Type[0] == 'event') {
					var s:Sprite = new Sprite();
					s.name = cuePoint.toXMLString()
					s.mouseChildren = false;
					s.buttonMode = true;
					s.x = cuePoint.Time[0]* width/soundEditorController.soundLength;
					cuePointLayer.addChild(s);
					s.graphics.beginFill(0x00FFFF);
					s.graphics.drawRect(0, 0, 1, height)
					s.graphics.endFill();
					s.addEventListener(MouseEvent.CLICK, function eClick(event:MouseEvent):void {
						//trace("clicked a cue point on the spectrum Display" + event.target.name);
						soundEditorController.selectedCuePoint = new XML(event.target.name);
					});
				}
			}
		}
		
		private function get soundEditorController():SoundEditorController {
			return mySoundEditorController;
		}
	}
}