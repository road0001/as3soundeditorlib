/**
 * Controls manipulating cue points
 */
 package com.tobydietrich.soundeditor.controller
{
	import com.tobydietrich.soundeditor.model.CueModel;
	
	public class CueController
	{
		private var myCueModel:CueModel;
		public function CueController(cueModel:CueModel) {
			myCueModel = cueModel;
		}
		
		public function addCue(name:String, time:int):void {
		    // TODO	
		}
		
	}
}