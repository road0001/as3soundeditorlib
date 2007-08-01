package com.tobydietrich.soundeditor.view
{
	import com.tobydietrich.soundeditor.controller.*;
	import com.tobydietrich.soundeditor.model.*;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ControlButtonsView extends Sprite
	{
      // the buttons
      private var myPlayButtonView:PlayButtonView;
      private var myRewindButtonView:RewindButtonView;
      private var myForwardButtonView:ForwardButtonView;

private var myPlayerController:PlayerController;

public function ControlButtonsView(playerController:PlayerController) {
	myPlayerController = playerController;
      		myRewindButtonView = new RewindButtonView();
      		addChild(myRewindButtonView);
      		myPlayButtonView = new PlayButtonView();
      		myPlayButtonView.x = ButtonView.BUTTON_SIZE*2;
      		addChild(myPlayButtonView);
      		myForwardButtonView = new ForwardButtonView();
      		myForwardButtonView.x = ButtonView.BUTTON_SIZE*4;
      		addChild(myForwardButtonView);
      	
      		rewindButtonView.addEventListener(MouseEvent.CLICK, playerController.eRewind);
      		playButtonView.addEventListener(MouseEvent.CLICK, playerController.ePlay);
      		forwardButtonView.addEventListener(MouseEvent.CLICK, playerController.eForward);
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
		public function playButtonEnabled(enabled:Boolean):void {
			myPlayButtonView.playButton.visible = enabled;
		}
		
		public function pauseButtonEnabled(enabled:Boolean):void {
			myPlayButtonView.pauseButton.visible = enabled;
		}
		
		public function forwardButtonEnabled(enabled:Boolean):void {
			myForwardButtonView.forwardButton.visible = enabled;
		}
		
	    public function rewindButtonEnabled(enabled:Boolean):void {
			myRewindButtonView.rewindButton.visible = enabled;
		}
		private function get playerController():PlayerController {
			return myPlayerController;
		}
		
	}
}