package com.tobydietrich.soundeditor.view
{
	import flash.display.Sprite;

	public class MouseOverSpriteView extends Sprite
	{
		public function MouseOverSpriteView()
		{
			//TODO: implement function
			super();
			controller.addEventListener(SoundEditorEvent.MOUSE_OVER_SPRITE), function eMouseOver(event:Event):void {
				trace(event.data);
			}
		}
		
	}
}