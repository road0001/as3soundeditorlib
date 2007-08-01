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
 
/**
 * Synchronizes the player and the sound.
 */
package com.tobydietrich.soundeditor.view
{
   import flash.display.Sprite;
   import flash.events.Event;
   
import com.tobydietrich.soundeditor.controller.SoundEditorController;
   public class SoundEditorView extends Sprite
   {
   	
   	
   	static public var FILL_COLOR:uint = 0x00FF00;
	   static public var SPECTRUM_HEIGHT:int = 200;
      static public var CURSOR_COLOR:uint = 0xFF0000;
      static public var SPECTRUM_WIDTH:int = 500;
   	
   	// loader views
      private var myCueLoaderView:LoaderView;
            private var mySoundLoaderView:LoaderView;
            private var mySpectrumSoundLoaderView:LoaderView;
            private var loaderWindow:Sprite; 
      
      private var mySoundEditorController:SoundEditorController;
      
	private var myControlButtonsView:ControlButtonsView;
 

      private var cursorView:CursorView;
      private var spectrumView:SpectrumView;
      

    /* Constructor */
      public function SoundEditorView(soundEditorController:SoundEditorController) {
      	mySoundEditorController = soundEditorController;
      	
      	//loader views
      	
      	
      	myCueLoaderView = new LoaderView(soundEditorController.cueLoaderModel);
      	mySoundLoaderView = new LoaderView(soundEditorController.soundLoaderModel);
      	mySpectrumSoundLoaderView = new LoaderView(soundEditorController.spectrumSoundLoaderModel);
      	loaderWindow = new Sprite();
      	addChild(loaderWindow);
      	myCueLoaderView.x = 100;
      	loaderWindow.addChild(myCueLoaderView);
      	mySoundLoaderView.x = 200;
      	loaderWindow.addChild(mySoundLoaderView);
      	mySpectrumSoundLoaderView.x = 300;
      	loaderWindow.addChild(mySpectrumSoundLoaderView);
      	
  		soundEditorController.addEventListener(Event.COMPLETE, eLoaded);
      }
      
      private function get soundEditorController():SoundEditorController {
      	return mySoundEditorController;
      }
      private function eLoaded(event:Event):void {
      	myControlButtonsView = new ControlButtonsView(soundEditorController.playerController);
      	soundEditorController.playerController.registerControlButtonsView(myControlButtonsView);
  		myControlButtonsView.x = 20;
  		myControlButtonsView.y = SoundEditorView.SPECTRUM_HEIGHT + 20;
  		addChild(myControlButtonsView);
  		
  		var musicView:Sprite = new Sprite();
  		
  		spectrumView = new SpectrumView(soundEditorController.spectrumModel);
         musicView.addChild(spectrumView);
         cursorView = new CursorView(soundEditorController.playerController);
		 musicView.addChild(cursorView);
  		
        addChild(musicView);
      		loaderWindow.visible = false;
      	}
      public function get cueLoaderView():LoaderView {
      	return myCueLoaderView;
      }
      public function get soundLoaderView():LoaderView {
      	return mySoundLoaderView;
      }
      public function get spectrumSoundLoaderView():LoaderView {
      	return mySpectrumSoundLoaderView;
      }
      
      public function get controlButtonsView():ControlButtonsView {
      	return myControlButtonsView;
      }
}
}