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
package com.tobydietrich.soundeditor.view
{
   import com.tobydietrich.soundeditor.controller.IMediaController;
   
   import com.tobydietrich.utils.TobyDietrichEvent;

   import flash.display.Sprite;
   import flash.events.MouseEvent;

   public class ControlButtonsView extends Sprite
   {
      // the buttons
      private var myPlayButtonView:PlayButtonView;
      private var myRewindButtonView:RewindButtonView;
      private var myForwardButtonView:ForwardButtonView;

      private var myMediaController:IMediaController;

      public function ControlButtonsView(mediaController:IMediaController) {
         myMediaController = mediaController;
         myRewindButtonView = new RewindButtonView();
         addChild(myRewindButtonView);
         myPlayButtonView = new PlayButtonView();
         myPlayButtonView.x = ButtonView.BUTTON_SIZE*2;
         addChild(myPlayButtonView);
         myForwardButtonView = new ForwardButtonView();
         myForwardButtonView.x = ButtonView.BUTTON_SIZE*4;
         addChild(myForwardButtonView);
          
         rewindButtonView.addEventListener(MouseEvent.CLICK, function eRewind(event:MouseEvent):void {
	         mediaController.rewindAll();
	      });
         playButtonView.addEventListener(MouseEvent.CLICK, function ePlay(event:MouseEvent):void {
	         mediaController.togglePlay();
	      });
         forwardButtonView.addEventListener(MouseEvent.CLICK, function eForward(event:MouseEvent):void {
	         mediaController.forwardAll();
	      });
	      
	      mediaController.addEventListener(TobyDietrichEvent.PLAYABLE_CHANGE, 
	         function eUpdate(event:TobyDietrichEvent):void {
		            paused(mediaController.paused);
		            forwardButtonEnabled(!mediaController.atEnd);
		            rewindButtonEnabled(!mediaController.atStart);
		      }
	      );
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
      private function get mediaController():IMediaController {
         return myMediaController;
      }
   }
}