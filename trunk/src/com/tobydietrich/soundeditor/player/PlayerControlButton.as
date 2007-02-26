package com.tobydietrich.soundeditor.player
{
	import flash.display.Sprite;

	public class PlayerControlButton extends Sprite
	{
		public function PlayerControlButton() {
			var child:Sprite = new Sprite();
			child.graphics.beginFill(0x666666);
			child.graphics.drawCircle(0, 0, PlayerControl.BUTTON_SIZE/2);
			child.graphics.endFill();
			addChild(child);
		}
	}
}