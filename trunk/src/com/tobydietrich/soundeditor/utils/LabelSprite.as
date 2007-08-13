/****
 * Base class for sprites on the filmstrip
 */
package com.tobydietrich.soundeditor.utils
{
	import flash.display.Sprite;

	public class LabelSprite extends Sprite
	{
          private var myLabel:String;
       public function get label():String {
         return myLabel;
       }
       
       public function LabelSprite(label:String='') {
       	myLabel = label;
       }
	}
}