/****
 * Base class for sprites on the filmstrip
 */
package com.tobydietrich.soundeditor.utils
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class LabelSprite extends Sprite
	{
       protected var label:TextField;
          
       public function get text():String {
         return label.text;
       }
       
       public function LabelSprite(x:int, y:int, strLabel:String='') {
       	this.x = x;
       	this.y = y;
       	if(strLabel != '') {
           var labelFormat:TextFormat = new TextFormat("Verdana", 8, 0x000000);

           var label:TextField = new TextField();
   		  label.autoSize = TextFieldAutoSize.LEFT;
           label.background = true;
           label.backgroundColor = 0xFFFFCC;
           label.border = true;
           label.borderColor = 0xCCCCCC;
           label.text = strLabel;
           label.defaultTextFormat = labelFormat;
	       	addChildAt(label,0);
       	}
       }
	}
}