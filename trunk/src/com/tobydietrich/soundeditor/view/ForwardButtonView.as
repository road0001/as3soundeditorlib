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
 * A forward button
 */
package com.tobydietrich.soundeditor.view
{
	import com.tobydietrich.soundeditor.controller.PlayerController;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.tobydietrich.soundeditor.utils.PlayableEvent;

	public class ForwardButtonView extends ButtonView
	{
		private var myForwardButton:Sprite;
		
		public function ForwardButtonView() {
			super();
			
			myForwardButton = new ButtonLabel('>>');
			addChildAt(myForwardButton, 0);
		}
		public function get enabled():Boolean {
			return myForwardButton.visible;
		}
		public function set enabled(e:Boolean):void {
			myForwardButton.visible = e;
		}
	}
}