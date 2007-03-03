package com.tobydietrich.soundeditor.view
{
	import flash.display.Sprite;
	import com.tobydietrich.soundeditor.controller.MusicController;
	import flash.events.*;

	public class CursorView extends Sprite
	{
		private var myMusicController:MusicController;
		private var cursorSprite:Sprite;
		public function CursorView(musicController:MusicController)
		{
			myMusicController = musicController;
			myMusicController.addEventListener(TimerEvent.TIMER, eTimer);
	     cursorSprite = new Sprite();
         cursorSprite.graphics.beginFill(MusicView.CURSOR_COLOR);
         cursorSprite.graphics.drawRect(0,MusicView.CHANNEL_HEIGHT/2,1,
           MusicView.CHANNEL_HEIGHT);
         cursorSprite.graphics.endFill();
         addChild(cursorSprite);
		}
		
		private function eTimer(event:TimerEvent):void {
			cursorSprite.x = MusicView.SOUND_WIDTH * 
			  event.target.soundModel.position / event.target.soundModel.length;
		}
	}
}