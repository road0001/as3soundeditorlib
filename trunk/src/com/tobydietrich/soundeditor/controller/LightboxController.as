/***
 * Controls a lightbox
 * 
 */
package com.tobydietrich.soundeditor.controller
{
	import com.tobydietrich.soundeditor.model.LightboxCursorModel;
	import com.tobydietrich.soundeditor.utils.PlayableEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class LightboxController extends EventDispatcher
	{
		private var myLightboxCursorModel:LightboxCursorModel;
		private var myMediaController:IMediaController;
		private var myFilmstrip:Sprite;
		private var myLightboxWidth:int;
		
		
		public function LightboxController(lightboxCursorModel:LightboxCursorModel, 
		 mediaController:IMediaController, filmstrip:Sprite, lightboxWidth:int) {
			myLightboxCursorModel = lightboxCursorModel;
			myMediaController = mediaController;
			myFilmstrip = filmstrip;
			myLightboxWidth = lightboxWidth;
			
			myLightboxCursorModel.addEventListener(Event.CHANGE, eChange);
            myMediaController.addEventListener(PlayableEvent.PROGRESS, eMediaUpdate);
            myMediaController.addEventListener(PlayableEvent.CHANGE, eMediaUpdate);
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
		
		private function eMediaUpdate(event:PlayableEvent):void {
			myLightboxCursorModel.update(Math.floor(myMediaController.fractionComplete / lightboxWidth) * lightboxWidth, 
			 myMediaController.fractionComplete % lightboxWidth);
		}
		
		public function get lightboxWidth():int {
			return myLightboxWidth;
		}
		public function get filmstrip():Sprite {
			return myFilmstrip;
		}
	}
}