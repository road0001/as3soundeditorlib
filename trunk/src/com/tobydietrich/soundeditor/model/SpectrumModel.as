/** 
 * This is basically an array
 */
package com.tobydietrich.soundeditor.model
{
	import flash.events.EventDispatcher;
	
	public class SpectrumModel extends EventDispatcher
	{
		private var myArrayLeft:Array = new Array();
		private var myArrayRight:Array = new Array();
		
		public function SpectrumModel() {
			
		}
		
		public function getLeftPeak(time:int):Number {
			return getPeak(myArrayLeft, time);
		}
		
		public function getRightPeak(time:int):Number {
			return getPeak(myArrayRight, time);
		}
		
		private function getPeak(myArray:Array, time:int):Number {
			// TODO: have it return the previous time, or something??
			if (myArray[time] == null) { 
			   return 0; 
			} else {
			   return myArray[time];
			}
		}
		
		public function addPeak(leftPeak:Number, rightPeak:Number, 
		 time:Number):void {
			myArrayLeft[time] = leftPeak;
			myArrayRight[time] = rightPeak;
		    dispatchEvent(new SpectrumModelEvent(SpectrumModelEvent.ADD_TIME, false, false, time));
		}
	}
}