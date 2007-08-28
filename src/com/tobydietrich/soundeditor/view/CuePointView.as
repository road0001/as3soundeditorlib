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
	import com.tobydietrich.soundeditor.model.CuePointModel;
	import com.tobydietrich.soundeditor.model.SoundModel;
	
	import flash.display.Sprite;

	public class CuePointView extends Sprite
	{
		private var myCuePointModel:CuePointModel;
		private var mySoundModel:SoundModel
		
		public function CuePointView(cuePointModel:CuePointModel, soundModel:SoundModel) 
		{
		 graphics.beginFill(0xFFFFFF, 0.01); // XXX
         graphics.drawRect(0, 0, SoundEditorView.SPECTRUM_WIDTH, SoundEditorView.SPECTRUM_HEIGHT);
         graphics.endFill();
         
			myCuePointModel = cuePointModel;
			mySoundModel = soundModel;
			for each(var cuePoint:XML in cuePointModel.xml.CuePoint) {
				if(cuePoint.Type != null && cuePoint.Type[0] == 'event') {
					drawEvent(cuePoint.Time[0], cuePoint.Name[0]);
				}
			}
		}
		
		
		
		public function get cuePointModel():CuePointModel {
			return myCuePointModel;
		}
		public function get soundModel():SoundModel {
			return mySoundModel;
		}
		
		private function drawEvent(time:int, name:int):void {
			graphics.beginFill(0x00FFFF);
			graphics.drawRect(time/soundModel.length*width, 0, 1, height);
			graphics.endFill();
		}
	}
}