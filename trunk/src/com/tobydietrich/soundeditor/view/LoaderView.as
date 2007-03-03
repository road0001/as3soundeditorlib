/***
 * Displays a little progress bar
 */
package com.tobydietrich.soundeditor.view
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import com.tobydietrich.soundeditor.controller.*;
	import com.tobydietrich.soundeditor.utils.*;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	public class LoaderView extends Sprite
	{
		static private var LOADER_HEIGHT:int = 10;
		static private var LOADER_WIDTH:int = 50;
		static private var TEXT_HEIGHT:int = 20;
		static private var BG_COLOR:uint = 0x000000;
		static private var FG_COLOR:uint = 0x00FF00;

		private var progressBar:Sprite;
		
		private var myLoaderController:LoaderController;
		
		public function LoaderView(loaderController:LoaderController) {
		   myLoaderController = loaderController;
		   var label:TextField = 
		      PopupLabel.createPopupLabel(myLoaderController.name + " load progress");
		   addChild(label);
		   
		   var box:Sprite = new Sprite();
		   box.graphics.beginFill(BG_COLOR);
		   box.graphics.drawRect(0, TEXT_HEIGHT, LOADER_WIDTH, LOADER_HEIGHT);
		   box.graphics.endFill();
		   addChild(box);
		   
		   progressBar = new Sprite();
		   progressBar.graphics.beginFill(FG_COLOR);
		   progressBar.graphics.drawRect(1,TEXT_HEIGHT+1, LOADER_WIDTH-2, LOADER_HEIGHT-2);
		   progressBar.scaleX = 0;
		   progressBar.graphics.endFill();
		   box.addChild(progressBar);
		   
		   myLoaderController.addEventListener(Event.COMPLETE, eComplete);
		   myLoaderController.addEventListener(ProgressEvent.PROGRESS, eProgress);
	   }
	   
	   private function eComplete(event:Event):void {
	   	progressBar.scaleX = 1;
	   }
	   
	   private function eProgress(event:ProgressEvent):void {
	   	progressBar.scaleX = myLoaderController.fractionLoaded;
	   }
	}
}