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
   import com.tobydietrich.soundeditor.utils.PlayableEvent;

   import flash.display.Sprite;
   import flash.events.MouseEvent;

   public class CursorView extends Sprite
   {
      private var cursorSprite:Sprite;
      private var myMediaController:IMediaController;

      public function CursorView(mediaController:IMediaController)
      {
         myMediaController = mediaController;
         cursorSprite = new Sprite();
         cursorSprite.graphics.beginFill(SoundEditorView.CURSOR_COLOR);
         cursorSprite.graphics.drawRect(0,0,1,SoundEditorView.SPECTRUM_HEIGHT);
         cursorSprite.graphics.endFill();
         addChild(cursorSprite);
         addEventListener(MouseEvent.CLICK, eClick);
         mediaController.addEventListener(PlayableEvent.PROGRESS, eUpdate);
         mediaController.addEventListener(PlayableEvent.CHANGE, eUpdate);
      }

      private function get mediaController():IMediaController {
         return myMediaController;
      }

      private function eUpdate(event:PlayableEvent):void {
         cursorSprite.x = SoundEditorView.SPECTRUM_WIDTH * mediaController.fractionComplete;
      }

      private function eClick(event:MouseEvent):void {
         mediaController.fractionComplete = event.localX / SoundEditorView.SPECTRUM_WIDTH;
      }

   }
}