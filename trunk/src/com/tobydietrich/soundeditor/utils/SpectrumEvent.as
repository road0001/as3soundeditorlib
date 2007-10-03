package com.tobydietrich.soundeditor.utils
{
	import flash.events.Event;

	public class SpectrumEvent extends Event
	{
		public static var PROGRESS:String = "SPECTRUM_PROGRESS";
		
		public var time:Number;
		     
		public function SpectrumEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, time:Number=0.0)
		{
			
			super(type, bubbles, cancelable);
			this.time = time;
		}
		
	}
}