package com.tobydietrich.soundeditor
{
	import flash.display.Sprite;
	import com.tobydietrich.soundeditor.view.SoundEditorView;
	import com.tobydietrich.soundeditor.controller.SoundEditorController;
	import com.tobydietrich.soundeditor.controller.LightboxController;
	import com.tobydietrich.soundeditor.model.LightboxCursorModel;
	import com.tobydietrich.soundeditor.view.LightboxView;
	
	public class SoundEditor extends Sprite 
	{
		public function SoundEditor(sndURL:String, cueURL:String) {
			
			var soundEditorController:SoundEditorController = 
			   new SoundEditorController(sndURL, cueURL);	
			var soundEditorView:SoundEditorView = new SoundEditorView(soundEditorController);
			addChild(soundEditorView);
			
		}
	}
}