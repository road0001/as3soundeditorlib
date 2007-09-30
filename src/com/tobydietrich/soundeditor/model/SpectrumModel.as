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
 * This is basically an array
 */
package com.tobydietrich.soundeditor.model
{
   import com.tobydietrich.soundeditor.utils.PlayableEvent;

   import flash.events.EventDispatcher;

   public class SpectrumModel extends EventDispatcher 	{
      private var mySpectrumModelXML:XML = <spectrummodel></spectrummodel>;
      
      private var mySoundModel:SoundModel;

      public function SpectrumModel(soundModel:SoundModel) {
         mySoundModel = soundModel;
         soundModel.volume = 0.01;
         soundModel.play();
         soundModel.addEventListener(PlayableEvent.PROGRESS, 
         	function eProgress(event:PlayableEvent):void {
		      	var peak:XML = <peak position={soundModel.position} 
		      	left={soundModel.leftPeak / soundModel.volume}
		      	right={soundModel.rightPeak / soundModel.volume} />;
		      	mySpectrumModelXML.appendChild(peak);
		        dispatchEvent(new PlayableEvent(PlayableEvent.PROGRESS, false, false, peak.@position));
      		}
      	 );
      }

      public function getPeak(time:int):XML {
         var peaks:XMLList = mySpectrumModelXML.peak.(@position <= time);
         if(peaks.length() == 0) {
         	return null;
         } else {
         	return peaks[peaks.length()-1];
         }
      }

      public function get soundModel():SoundModel {
         return mySoundModel;
      }
      
      public function get spectrumModelXML():XML {
      	return mySpectrumModelXML;
      }
   }
}