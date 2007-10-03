package com.tobydietrich.soundeditor.utils
{
	import flash.events.Event;

	public class CuePointEvent extends Event
	{
		// select a new cue point
		public static var SELECT_NEW:String = "CUE_POINT_SELECT_NEW";
		// update the cue point list
		public static var UPDATE:String = "CUE_POINT_UPDATE";
		
		
		public function CuePointEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
	}
}