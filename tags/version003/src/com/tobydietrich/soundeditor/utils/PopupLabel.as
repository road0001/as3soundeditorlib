package com.tobydietrich.soundeditor.utils
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFieldAutoSize;
	
	public class PopupLabel
	{
		/**
		 * Just defines a label format
		 */
		static public function createPopupLabel( text:String ):TextField {
		   var labelFormat:TextFormat =
              new TextFormat("Verdana", 8, 0x000000);

           var label:TextField = new TextField();
		   label.autoSize = TextFieldAutoSize.LEFT;
           label.background = true;
           label.backgroundColor = 0xFFFFCC;
           label.border = true;
           label.borderColor = 0xCCCCCC;
           label.text = text;
           label.defaultTextFormat = labelFormat;
           return label;
		}
	}
}