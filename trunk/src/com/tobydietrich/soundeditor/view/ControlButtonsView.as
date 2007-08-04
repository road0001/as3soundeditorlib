package com.tobydietrich.soundeditor.view
{
	import com.tobydietrich.soundeditor.controller.*;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ControlButtonsView extends Sprite
	{
      // the buttons
      private var myPlayButtonView:PlayButtonView;
      private var myRewindButtonView:RewindButtonView;
      private var myForwardButtonView:ForwardButtonView;

private var myMusicPlayerController:MusicPlayerController;

public function ControlButtonsView(musicMusicPlayerController:MusicPlayerController) {
	myMusicPlayerController = musicMusicPlayerController;
      		myRewindButtonView = new RewindButtonView();
      		addChild(myRewindButtonView);
      		myPlayButtonView = new PlayButtonView();
      		myPlayButtonView.x = ButtonView.BUTTON_SIZE*2;
      		addChild(myPlayButtonView);
      		myForwardButtonView = new ForwardButtonView();
      		myForwardButtonView.x = ButtonView.BUTTON_SIZE*4;
      		addChild(myForwardButtonView);
      	
      		rewindButtonView.addEventListener(MouseEvent.CLICK, eRewind);
      		playButtonView.addEventListener(MouseEvent.CLICK, ePlay);
      		forwardButtonView.addEventListener(MouseEvent.CLICK, eForward);
}	
		
		public function get playButtonView():PlayButtonView {
			return myPlayButtonView;
		}
		public function get rewindButtonView():RewindButtonView {
			return myRewindButtonView;
		}
		public function get forwardButtonView():ForwardButtonView {
			return myForwardButtonView;
		}
		public function paused(e:Boolean):void {
			myPlayButtonView.paused = e;
		}
		
		public function forwardButtonEnabled(enabled:Boolean):void {
			myForwardButtonView.enabled = enabled;
		}
		
	    public function rewindButtonEnabled(enabled:Boolean):void {
			myRewindButtonView.enabled = enabled;
		}
		private function get musicMusicPlayerController():MusicPlayerController {
			return myMusicPlayerController;
		}
		private function eRewind(event:MouseEvent):void {
			musicMusicPlayerController.rewindAll();
		}
		private function eForward(event:MouseEvent):void {
			musicMusicPlayerController.forwardAll();
		}
		private function ePlay(event:MouseEvent):void {
			musicMusicPlayerController.play();
		}
	}
}