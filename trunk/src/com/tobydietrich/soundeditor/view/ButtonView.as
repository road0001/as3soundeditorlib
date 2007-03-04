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
	import com.tobydietrich.soundeditor.controller.MusicController;
	import com.tobydietrich.soundeditor.utils.PopupLabel;
	
	import flash.display.Sprite;
	import flash.text.TextField;

	public class ButtonView extends Sprite
	{
	    static public var BUTTON_COLOR:uint = 0xFFFFFFF;
	    static public var BUTTON_ALPHA:Number = 0.2;
	    static public var BUTTON_SIZE:int = 10;
	    static public var REWIND_BUTTON_COLOR:uint = 0x00FF00;
	    static public var FORWARD_BUTTON_COLOR:uint = 0x00FF00;
		static public var PLAY_BUTTON_COLOR:uint = 0x00FF00;
		static public var PAUSE_BUTTON_COLOR:uint = 0xFF0000;
	    
	    protected var myMusicController:MusicController;
	    	
	    protected var buttonSprite:Sprite;
	    	
		public function ButtonView(musicController:MusicController) {
			super();
			myMusicController = musicController;
			buttonSprite = new Sprite();
			buttonSprite.graphics.beginFill(BUTTON_COLOR, BUTTON_ALPHA);
			buttonSprite.graphics.drawCircle(0, 0, BUTTON_SIZE);
			buttonSprite.graphics.endFill();
			addChild(buttonSprite);
		}
	}
}