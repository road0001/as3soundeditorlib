package com.audeto.as3soundeditorlib.sound
{
	import flash.display.Sprite;

	public class SpectrumGraph extends Sprite
	{
		private var FILL_COLOR:uint = 0x00FF00;
		
		private var CHANNEL_HEIGHT:int = 100;
		
		public function SpectrumGraph(width:int, height:int, snd_URL:String) 
		{
			trace('entered spectrum graph');
			//this.width = width;
			//this.height = height;
			var midline:Sprite = new Sprite();
			midline.x = 0;
			midline.y = CHANNEL_HEIGHT;
			midline.graphics.beginFill(FILL_COLOR);
			midline.graphics.drawRect(0, 0, 500, 1);
			midline.graphics.endFill();
			addChild(midline);
			new SpectrumGraphSegment(this, snd_URL, 0, 0);
		}		
		
		public function drawSegment(leftVolume:Number, rightVolume:Number, time:Number):void {
			var right:Sprite = new Sprite();
			right.x = time/40;
			right.y = CHANNEL_HEIGHT;
			right.graphics.beginFill(FILL_COLOR);
			right.graphics.drawRect(0, 0, 1, rightVolume*CHANNEL_HEIGHT);
			right.graphics.endFill();
			addChild(right);
			var left:Sprite = new Sprite();
			left.x = time/40;
			left.y = CHANNEL_HEIGHT-leftVolume*CHANNEL_HEIGHT;
			left.graphics.beginFill(FILL_COLOR);
			left.graphics.drawRect(0, 0, 1, leftVolume*CHANNEL_HEIGHT);
			left.graphics.endFill();
			addChild(left);
		}
	}
}