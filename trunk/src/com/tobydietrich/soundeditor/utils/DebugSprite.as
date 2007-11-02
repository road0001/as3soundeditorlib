package com.tobydietrich.soundeditor.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.tobydietrich.soundeditor.utils.SoundEditorEvent;

	public class DebugSprite extends Sprite
	{
		public function DebugSprite()
		{
			super();
			addEventListener(MouseEvent.MOUSE_OVER, function eOver(event:Event):void {
				trace("Mouseover " + event.target.name);
				dispatchEvent(new SoundEditorEvent(SoundEditorEvent.MOUSE_OVER_SPRITE, false, false, this.data));
			});
		}
		
	}
}