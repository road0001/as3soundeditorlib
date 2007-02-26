/***
 * Displays a little progress bar
 */
package com.tobydietrich.soundeditor.utils
{
	import flash.display.Sprite;
	import flash.text.TextField;

	public class LoaderSprite extends Sprite
	{
		// the label that we give to the object
		private var strLabel:String;
		
		// the fraction complete
		private var myFraction:Number = 0;
		
		// the height of the widget
		private var myHeight:int = 10;
		
		// the width of the widget
		private var myWidth:int = 50;
		
		// is the load complete
		private var myComplete:Boolean= false;
		
		private var myTextHeight:int = 20;
		// the progress bar
		private var bar:Sprite;
		
		public function LoaderSprite(label:String) {
		   var m_label:TextField = 
		      PopupLabel.createPopupLabel(label + " load progress");
		   addChild(m_label);
		   
		   
		   var child:Sprite = new Sprite();
		   child.graphics.beginFill(0x000000);
		   child.graphics.drawRect(0, myTextHeight, myWidth, myHeight);
		   child.graphics.endFill();
		   addChild(child);
		   
		   bar = new Sprite();
		   bar.graphics.beginFill(0x00FF00);
		   bar.graphics.drawRect(1,myTextHeight+1, myWidth-2, myHeight-2);
		   bar.scaleX = 0;
		   bar.graphics.endFill();
		   child.addChild(bar);
	   }
	   
	   public function set complete(b:Boolean):void {
	   	fractionComplete = 1;
	   	myComplete = b;
	   }
	   
	   public function get complete():Boolean { 
	   	return myComplete;
	   }
	   
	   public function set fractionComplete(p:Number):void { 
	   	bar.scaleX = myFraction;
	   	myFraction = p;
	   }
	   
	   public function get fractionComplete():Number { 
	   	return myFraction;
	   }
	}
}