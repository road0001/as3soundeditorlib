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
      private var myPlayButtonView:PlayButtonView;

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
      	myCueLoaderView.x = 50;
      	loaderWindow.addChild(myCueLoaderView);
      	mySoundLoaderView.x = 100;
      	loaderWindow.addChild(mySoundLoaderView);
      	mySpectrumSoundLoaderView.x = 150;
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
      		 mySpectrumController, 10, 10);
      		addChild(myMusicView);
      		myPlayButtonView = new PlayButtonView(myMusicController);
      		myPlayButtonView.x = 20;
      		myPlayButtonView.y = 50;
      		addChild(myPlayButtonView);
      		
      		loaderWindow.visible = false;
      	}
      }
      
      
}
}