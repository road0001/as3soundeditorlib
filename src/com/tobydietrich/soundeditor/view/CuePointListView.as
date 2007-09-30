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
	import com.tobydietrich.soundeditor.model.CuePointModel;
	import com.tobydietrich.soundeditor.model.SoundModel;
	import com.tobydietrich.soundeditor.utils.LabelSprite;
	
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;

	public class CuePointListView extends Sprite
	{
		public static var CUE_POINT_LIST_VIEW_WIDTH:int = 200;
		public static var CUE_POINT_LIST_VIEW_ITEM_HEIGHT:int = 20;
		private var myCuePointModel:CuePointModel;
		private var mySoundModel:SoundModel
		
		public function CuePointListView(cuePointModel:CuePointModel, soundModel:SoundModel) 
		{
		 graphics.beginFill(0xFFFFFF, 0.01); // XXX
         graphics.drawRect(0, 0, CUE_POINT_LIST_VIEW_WIDTH, cuePointModel.numCuePoints * CUE_POINT_LIST_VIEW_ITEM_HEIGHT);
         graphics.endFill();
         
			myCuePointModel = cuePointModel;
			mySoundModel = soundModel;
			
			var style:StyleSheet = new StyleSheet();
			
			var styleObj:Object = new Object();
			styleObj.fontSize = "bold";
			styleObj.color = "#000000";
			style.setStyle(".time", styleObj);
			style.setStyle(".name", styleObj);
			var tf:TextField = new TextField();
			tf.styleSheet = style;
			tf.htmlText = "<span class = 'name'>Event </span> <span class = 'time'>Time</span>";
			
			this.addChild(tf);
			var s:DisplayObject;
			s = drawEventLink("0", "Start");
			s.y = 1 * CUE_POINT_LIST_VIEW_ITEM_HEIGHT;
			this.addChild(s);
			var i:int = 2;
			for each(var cuePoint:XML in cuePointModel.xml.CuePoint) {
				if(cuePoint.Type != null && cuePoint.Type[0] == 'event') {
					s = drawEventLink(cuePoint.Time[0], cuePoint.Name[0]);
					s.y = i * CUE_POINT_LIST_VIEW_ITEM_HEIGHT;
					this.addChild(s);
					i++;
				}
			}
			s = drawEventLink(new String(soundModel.length), "End");
			s.y = i * CUE_POINT_LIST_VIEW_ITEM_HEIGHT;
			this.addChild(s);
		}
		
		
		
		public function get cuePointModel():CuePointModel {
			return myCuePointModel;
		}
		public function get soundModel():SoundModel {
			return mySoundModel;
		}
		
		private function drawEventLink(time:String, name:String):DisplayObject {
			

			var style:StyleSheet = new StyleSheet();
			
			var styleObj:Object = new Object();
			styleObj.fontSize = "bold";
			styleObj.color = "#000000";
			style.setStyle(".time", styleObj);
			style.setStyle(".name", styleObj);
			var tf:TextField = new TextField();
			tf.styleSheet = style;
			tf.htmlText = "<span class = 'name'>" + pad(name, " ", 5, false) + "</span> <span class = 'time'> " + getMusicTime(time) +  "</span>";
			
			var up:Sprite = new Sprite();
			up.graphics.beginFill(0xCCCCCC, 0.3);
			up.graphics.drawRect(0,0,tf.width, tf.height);
			up.graphics.endFill();
			
			var s:Sprite = new Sprite();
			s.name = new XML(<event name={name} time={time} />).toXMLString();
			s.mouseChildren = false;
			s.buttonMode = true;
			s.addChild(up);
			s.addChild(tf);
			s.addEventListener(MouseEvent.CLICK, function click(event:Event):void { 
				trace("click " + event.target.name); 
				soundModel.position = new XML(event.target.name).@time; 
			});
			
			return s;
		}
		
		// these functions should be somewhere in Flash...
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