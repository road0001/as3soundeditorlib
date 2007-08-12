package com.tobydietrich.soundeditor.utils
{
	import flash.display.*;
	
	public class DisplayObjectTraceXML
	{
		public static function traceXML(dispObj:DisplayObject):XML {
	     var temp:XML = innerTraceXML(dispObj);

         return new XML('<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
         + temp.toXMLString());
      }

      private static function innerTraceXML(dispObj:DisplayObject):XML {
      	var spriteXML:XML;
         if(dispObj is Sprite) {
            var sp:Sprite = dispObj as Sprite;
            if(sp is LabelSprite) {
               var ls:LabelSprite = sp as LabelSprite;
               spriteXML = <sprite label={ls.text} x={ls.x} y={ls.y} height={ls.height} width={ls.width} />;
            } else {
               spriteXML = <sprite x={sp.x} y={sp.y} height={sp.height} width={sp.width} />;
            }
            for (var i:int = 0; i< sp.numChildren; i++) {
               var child:DisplayObject = sp.getChildAt(i);
               spriteXML.appendChild(innerTraceXML(child));
            }
         } else {
            spriteXML = <dispObj x={dispObj.x} y={dispObj.y} height={dispObj.height} width={dispObj.width} />;
         }
         return spriteXML;
      }
	}
}