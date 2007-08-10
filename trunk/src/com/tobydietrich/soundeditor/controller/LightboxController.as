/***
 * Controls a lightbox
 * 
 */
package com.tobydietrich.soundeditor.controller
{
	import com.tobydietrich.soundeditor.model.*;
	import com.tobydietrich.soundeditor.utils.PlayableEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class LightboxController extends EventDispatcher
	{
		private var myLightboxCursorModel:LightboxCursorModel;
		private var myFilmstrip:Sprite;
		private var myLightboxWidth:int;
		
		
		public function LightboxController(lightboxCursorModel:LightboxCursorModel, 
		 filmstrip:Sprite, lightboxWidth:int) {
			myLightboxCursorModel = lightboxCursorModel;
			myFilmstrip = filmstrip;
			myLightboxWidth = lightboxWidth;
			
			myLightboxCursorModel.addEventListener(Event.CHANGE, eChange);
		}
		
		public function get frameStart():Number {
			return myLightboxCursorModel.frameStart;
		}
		public function set frameStart(fraction:Number):void {
			myLightboxCursorModel.frameStart = fraction;
		}
		
		public function get cursorPosition():Number {
			return myLightboxCursorModel.cursorPosition;
		}
		public function set cursorPosition(fraction:Number):void {
			myLightboxCursorModel.cursorPosition = fraction;
		}
		
		private function eChange(event:Event):void {
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function eMediaUpdate(event:PlayableEvent):void {
			myLightboxCursorModel.update(Math.floor(event.target.fractionComplete / lightboxWidth) * lightboxWidth, 
			 event.target.fractionComplete % lightboxWidth);
		}
		
		public function get lightboxWidth():int {
			return myLightboxWidth;
		}
		public function get filmstrip():Sprite {
			return myFilmstrip;
		}
	}
}