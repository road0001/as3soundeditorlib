package com.tobydietrich.soundeditor.model
{
	import flash.events.Event;

	public class SpectrumModelEvent extends Event
	{
		static public var ADD_TIME = 1;
		
		private var myTime:int;
		
		public function SpectrumModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, time:int = 0)
		{
			super(type, bubbles, cancelable);
			myTime = time;
			
		}
		
		public function get time():int {
			return myTime;
		}
	}
}