/***
 *Copyright (c) 2007 Charles M. Dietrich
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the  "Software"), to 
 * deal in the Software without restriction, including without limitation the 
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
 * sell copies of the Software, and to permit persons to whom the Software is 
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in 
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
 * THE SOFTWARE.
 */
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