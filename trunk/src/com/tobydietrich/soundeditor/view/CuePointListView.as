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
	import com.tobydietrich.soundeditor.controller.SoundEditorController;
	import com.tobydietrich.utils.TobyDietrichEvent;
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	public class CuePointListView extends Sprite
	{
		public static var CUE_POINT_LIST_VIEW_WIDTH:int = 200;
		public static var CUE_POINT_LIST_VIEW_ITEM_HEIGHT:int = 20;
		private var mySoundEditorController:SoundEditorController;
		private var style:StyleSheet = new StyleSheet();
		private var overArr:Object = {};
		
		public function CuePointListView(soundEditorController:SoundEditorController) 
		{
			// cache the controller
			mySoundEditorController = soundEditorController;
			
			// attach event listeners
			soundEditorController.addEventListener(TobyDietrichEvent.CUE_POINT_SELECT_NEW, function eSelectNew(event:TobyDietrichEvent):void {
				//trace("selecting " + event.target.selectedCuePoint.toXMLString());
				for each(var key:Object in overArr) {
					key.visible = false;
				}
				overArr[event.target.selectedCuePoint.Time[0]].visible = true;
			});
			
			soundEditorController.addEventListener(TobyDietrichEvent.CUE_POINT_UPDATE, function eUpdate(event:TobyDietrichEvent):void {
				trace ("updating" + event.target);
			});
			
			// create stylesheet
			var styleObj:Object = new Object();
			styleObj.fontSize = "bold";
			styleObj.color = "#000000";
			style.setStyle(".time", styleObj);
			style.setStyle(".name", styleObj);
			
			// create the bounding box
		 	graphics.beginFill(0xFFFFFF, 0.01); // XXX
         	graphics.drawRect(0, 0, CUE_POINT_LIST_VIEW_WIDTH, soundEditorController.numCuePoints * CUE_POINT_LIST_VIEW_ITEM_HEIGHT);
         	graphics.endFill();
			
			// create the initial table
			addCuePoints(soundEditorController.cuePointList);
			

		}
		
		private function addCuePoints(cuePointList:XMLList):void {
			var table:XML = <p>Event__________Time___________(ms)</p>;
			// create the table
			var tf:TextField = new TextField();
			tf.styleSheet = style;
			tf.width = CUE_POINT_LIST_VIEW_WIDTH;
			tf.height = CUE_POINT_LIST_VIEW_ITEM_HEIGHT;
			tf.htmlText = table.toXMLString();
			
			this.addChild(tf);
			var s:DisplayObject;
			s = drawEventLink(<CuePoint>
			    <Time>0</Time>
			    <Type>event</Type>
			    <Name>Mp3 Start</Name>
			  </CuePoint>);
			s.y = 1 * CUE_POINT_LIST_VIEW_ITEM_HEIGHT;
			this.addChild(s);
			var i:int = 2;
			for each(var cuePoint:XML in cuePointList) {
				if(cuePoint.Type != null && cuePoint.Type[0] == 'event') {
					s = drawEventLink(cuePoint);
					s.y = i * CUE_POINT_LIST_VIEW_ITEM_HEIGHT;
					this.addChild(s);
					i++;
				}
			}
			s = drawEventLink(<CuePoint>
			    <Time>{new String(soundEditorController.soundLength)}</Time>
			    <Type>event</Type>
			    <Name>MP3 End</Name>
			  </CuePoint>);
			s.y = i * CUE_POINT_LIST_VIEW_ITEM_HEIGHT;
			this.addChild(s);
		}
		
		private function drawEventLink(cuePoint:XML):DisplayObject {
			var table:XML = <p>{pad(cuePoint.Name[0], " ", 5, false) + "___" + 
			getMusicTime(cuePoint.Time[0]) + "___" + cuePoint.Time[0]}</p>;
			
			var tf:TextField = new TextField();
			tf.styleSheet = style;
			tf.width = CUE_POINT_LIST_VIEW_WIDTH;
			tf.height = CUE_POINT_LIST_VIEW_ITEM_HEIGHT;
			tf.htmlText = table.toXMLString();
			
			var up:Sprite = new Sprite();
			up.graphics.beginFill(0xCCCCCC, 0.3);
			up.graphics.drawRect(0,0,CUE_POINT_LIST_VIEW_WIDTH, CUE_POINT_LIST_VIEW_ITEM_HEIGHT-1);
			up.graphics.endFill();
			
			var over:Sprite = new Sprite();
			over.graphics.beginFill(0x00FF00, 0.3);
			over.graphics.drawRect(0,0,CUE_POINT_LIST_VIEW_WIDTH, CUE_POINT_LIST_VIEW_ITEM_HEIGHT-1);
			over.graphics.endFill();
			over.visible = false;
			overArr[cuePoint.Time[0]] = over;
			
			var s:Sprite = new Sprite();
			s.name = cuePoint.toXMLString();
			s.mouseChildren = false;
			s.buttonMode = true;
			s.addChild(up);
			s.addChild(over);
			s.addChild(tf);
			
			s.addEventListener(MouseEvent.CLICK, function eClick(event:MouseEvent):void { 
				//trace("cue point clicked");
				soundEditorController.selectedCuePoint = new XML(event.target.name);
			});
			
			return s;
		}
		private function get soundEditorController():SoundEditorController {
			return mySoundEditorController;
		}
		// these functions should be somewhere in Flash libraries
		private function getMusicTime(time:String):String {
			var date:Date = new Date(new Number(time));
			return date.getUTCHours() + ":" + 
				doubleDigitFormat(date.getUTCMinutes()) + ":" + 
				doubleDigitFormat(date.getSeconds()) + "." + 
				tripleDigitFormat(date.getMilliseconds());
		}
		
		private function pad(s:String, padChar:String, size:int, left:Boolean=true):String {
			while(s.length < size) {
				if(left) {
					s = padChar + s;
				} else {
					s += padChar;
				}
			}
			return s;
		}
		private function doubleDigitFormat(num:uint):String {
			return pad(new String(num), "0", 2);
		}
		private function tripleDigitFormat(num:uint):String {
			return pad(new String(num), "0", 3);
		}
		
	}
}