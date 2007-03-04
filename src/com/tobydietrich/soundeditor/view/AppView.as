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
   import com.tobydietrich.soundeditor.controller.*;
   import com.tobydietrich.soundeditor.model.*;
   import flash.events.Event;

   public class AppView extends Sprite
   {
   	// loaders
   	private var myCueLoaderController:CueLoaderController;
   	// for the playhead
   	private var mySoundLoaderController:SoundLoaderController;
   	// to generate the spectrum
   	private var mySpectrumSoundLoaderController:SoundLoaderController;
   	
   	// loader views
      private var myCueLoaderView:LoaderView;
            private var mySoundLoaderView:LoaderView;
            private var mySpectrumSoundLoaderView:LoaderView;
            private var loaderWindow:Sprite; 
   	
   	// models
   	
      	private var myCueModel:CueModel;
      	// for the playhead
      	private var mySoundModel:SoundModel;
      	// to generate the spectrum
      	private var mySpectrumSoundModel:SoundModel;
   	private var mySpectrumModel:SpectrumModel;
   	

            
// controllers
private var myCueController:CueController;
      private var myMusicController:MusicController;
            private var mySpectrumMusicController:MusicController;
   	      private var mySpectrumController:SpectrumController;
      
      // views
      private var myMusicView:MusicView;
      
      // the buttons
      private var myPlayButtonView:PlayButtonView;
      private var myRewindButtonView:RewindButtonView;
      private var myForwardButtonView:ForwardButtonView;

/* Constructor */
      public function AppView(sndURL:String, cueURL:String) {
      	
      	
      //loaders
      	myCueLoaderController = new CueLoaderController(cueURL);
      	myCueLoaderController.addEventListener(Event.COMPLETE, eCueLoaded);
      	mySoundLoaderController = new SoundLoaderController(sndURL);
      	mySoundLoaderController.addEventListener(Event.COMPLETE, eSoundLoaded);
      	mySpectrumSoundLoaderController = new SoundLoaderController(sndURL);
      	mySpectrumSoundLoaderController.addEventListener(Event.COMPLETE, eSpectrumSoundLoaded);
      	
      	//loader views
      	
      	myCueLoaderView = new LoaderView(myCueLoaderController);
      	mySoundLoaderView = new LoaderView(mySoundLoaderController);
      	mySpectrumSoundLoaderView = new LoaderView(mySpectrumSoundLoaderController);
      	loaderWindow = new Sprite();
      	addChild(loaderWindow);
      	myCueLoaderView.x = 100;
      	loaderWindow.addChild(myCueLoaderView);
      	mySoundLoaderView.x = 200;
      	loaderWindow.addChild(mySoundLoaderView);
      	mySpectrumSoundLoaderView.x = 300;
      	loaderWindow.addChild(mySpectrumSoundLoaderView);
      }
      
      private function eCueLoaded(event:Event):void {
      	myCueModel = new CueModel(event.target.cuePoints);
      	myCueController = new CueController(myCueModel);
      	check();
      }
      
      private function eSoundLoaded(event:Event):void {
      	mySoundModel = new SoundModel(event.target.sound);
      	myMusicController = new MusicController(mySoundModel);
      	check();
      }
      
      private function eSpectrumSoundLoaded(event:Event):void {
      	mySpectrumSoundModel = new SoundModel(event.target.sound);
      	mySpectrumMusicController = new MusicController(mySpectrumSoundModel);
      	mySpectrumModel = new SpectrumModel();
      	mySpectrumController = new SpectrumController(mySpectrumMusicController, mySpectrumModel);
      	check();
      }
      
      private function check():void {
      	if(myCueController != null && myMusicController != null 
      	 && mySpectrumController != null) {
      		myMusicView = new MusicView(myCueController, myMusicController, 
      		 mySpectrumController, 0, 0);
      		addChild(myMusicView);
      		var buttons:Sprite = new Sprite();
      		buttons.x = 20;
      		buttons.y = MusicView.SPECTRUM_HEIGHT + 20;
      		addChild(buttons);
      		myRewindButtonView = new RewindButtonView(myMusicController);
      		buttons.addChild(myRewindButtonView);
      		myPlayButtonView = new PlayButtonView(myMusicController);
      		myPlayButtonView.x = ButtonView.BUTTON_SIZE*2;
      		buttons.addChild(myPlayButtonView);
      		myForwardButtonView = new ForwardButtonView(myMusicController);
      		myForwardButtonView.x = ButtonView.BUTTON_SIZE*4;
      		buttons.addChild(myForwardButtonView);
      		loaderWindow.visible = false;
      	}
      }
      
      
}
}