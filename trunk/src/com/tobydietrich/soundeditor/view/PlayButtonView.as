/***
 * A player control, complete with silly graphics
 */
package com.tobydietrich.soundeditor.view
{
	import flash.display.Sprite;
	import flash.events.*;
	import com.tobydietrich.soundeditor.controller.MusicController;

	public class PlayButtonView extends Sprite
	{
		static public var BUTTON_COLOR:uint = 0x000000;
		static public var PLAY_BUTTON_COLOR:uint = 0x00FF00;
		static public var PAUSE_BUTTON_COLOR:uint = 0xFF0000;
	   static public var BUTTON_SIZE:int = 20;
		
		private var myMusicController:MusicController;
		
		private var playButton:Sprite;
		private var pauseButton:Sprite;
		
		public function PlayButtonView(musicController:MusicController) {
			myMusicController = musicController;
			var buttonSprite:Sprite = new Sprite();
			buttonSprite.graphics.beginFill(BUTTON_COLOR);
			buttonSprite.graphics.drawCircle(0, 0, BUTTON_SIZE);
			buttonSprite.graphics.endFill();
			buttonSprite.addEventListener(MouseEvent.CLICK, ePlayPause);
			addChild(buttonSprite);
			
			playButton = new Sprite();
			playButton.graphics.beginFill(PLAY_BUTTON_COLOR);
			playButton.graphics.drawCircle(0, 0, BUTTON_SIZE/3);
			playButton.graphics.endFill();
			addChild(playButton);
			
			pauseButton = new Sprite();
			pauseButton.graphics.beginFill(PAUSE_BUTTON_COLOR);
			pauseButton.graphics.drawCircle(0, 0, BUTTON_SIZE/3);
			pauseButton.graphics.endFill();
			addChild(pauseButton);
			pauseButton.visible = false;
			
			

		}
		
		private function ePlayPause(event:MouseEvent):void {
			if(myMusicController.soundModel.playing) {
				myMusicController.pause();
			} else {
			    myMusicController.play();
			}
		    playButton.visible = !myMusicController.soundModel.playing;
		    pauseButton.visible = myMusicController.soundModel.playing;
		}
		
	}
}