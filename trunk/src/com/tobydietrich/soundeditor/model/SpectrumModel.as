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
		   dispatchEvent(new SpectrumModelEvent(SpectrumModelEvent.ADD_TIME, 
		    false, false, time));
		}
	}
}