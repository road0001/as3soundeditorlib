/***
 * Models a cursor that has a frameStart and cursorPosition
 * The frameStart is the fraction of the complete filmstrip
 * The cursorPosition is fraction of the shown filmstrip
 */

package com.tobydietrich.soundeditor.model
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class LightboxCursorModel extends EventDispatcher
	{
		private var myFrameStart:Number = 0;
		private var myCursorPosition:Number = 0;
		public function LightboxCursorModel() {
			
		}
		public function get frameStart():Number {
			return myFrameStart;
		}
		public function set frameStart(fraction:Number):void {
			myFrameStart = fraction;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get cursorPosition():Number {
			return myCursorPosition;
		}
		public function set cursorPosition(fraction:Number):void {
			myCursorPosition = fraction;
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function update(fStart:Number, cPos:Number):void {
			myFrameStart = fStart;
			myCursorPosition = cPos;
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}