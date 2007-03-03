package com.tobydietrich.soundeditor.view
{
	import flash.display.Sprite;
	import com.tobydietrich.soundeditor.controller.CueController;

	public class CueView extends Sprite
	{
		private var myCueController:CueController;
		public function CueView(cueController:CueController)
		{
			myCueController = cueController;
		}
		
	}
}