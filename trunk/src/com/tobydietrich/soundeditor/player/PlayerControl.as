/***
 * A player control, complete with silly graphics
 */
package com.tobydietrich.soundeditor.player
{
	import flash.display.Sprite;
	import flash.events.*;

	public class PlayerControl extends Sprite
	{
		private var myMedia:Playable;
		
		static public var BUTTON_SIZE:int = 50;
		
		private var myRewindAll:PlayerControlButton = new PlayerControlButton();
		
		private var myPlay:PlayerControlButton = new PlayerControlButton();
		
		private var myForwardAll:PlayerControlButton = new PlayerControlButton();
		
		
		public function PlayerControl(media:Playable) {
			addChild(myRewindAll);
			addChild(myPlay);
			addChild(myForwardAll);
			myMedia = media;
			myPlay.x = BUTTON_SIZE;
			myForwardAll.x = BUTTON_SIZE*2;
			myRewindAll.addEventListener(MouseEvent.CLICK, rewindAll);
			myPlay.addEventListener(MouseEvent.CLICK, play);
			myForwardAll.addEventListener(MouseEvent.CLICK, forwardAll);	
		}
		
		private function rewindAll(event:MouseEvent):void {
			myMedia.rewindAll();
		}
		private function play(event:MouseEvent):void {
			if(myMedia.playing) {
				myMedia.pause();
			} else if (myMedia.paused || myMedia.stopped) {
				myMedia.play();
			}
		}
		private function forwardAll(event:MouseEvent):void {
			myMedia.forwardAll();
		}
		
	}
}