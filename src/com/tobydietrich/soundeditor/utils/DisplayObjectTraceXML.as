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
package com.tobydietrich.soundeditor.utils
{
   import flash.display.*;

   public class DisplayObjectTraceXML
   {
 
      public static function traceXML(dispObj:DisplayObject, depth:int=-1):XML {
         var tmp:XML = innerTraceXML(dispObj, depth);

         return new XML('<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
         + tmp.toXMLString());
      }

      private static function innerTraceXML(dispObj:DisplayObject, depth:int=-1):XML {
  	    if(dispObj.width > 100000 || dispObj.width < 0 || dispObj.height > 100000 || dispObj.height < 0) {
				var tmp2:XML = <insane name={dispObj.name} width={dispObj.width} height={dispObj.height} />;
				trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + tmp2.toXMLString());
		}
         var spriteXML:XML;
         if(dispObj is DisplayObjectContainer) {
            var sp:DisplayObjectContainer = dispObj as DisplayObjectContainer;

            spriteXML = <sprite name={sp.name} x={sp.x} y={sp.y} height={sp.height} width={sp.width} scaleX={sp.scaleX} scaleY={sp.scaleY} scale9Grid={sp.scale9Grid} />;
            for (var i:int = 0; i< sp.numChildren; i++) {
               var child:DisplayObject = sp.getChildAt(i);
               if(depth == -1) {
               spriteXML.appendChild(innerTraceXML(child));
               } else if (depth > 1) {
               	spriteXML.appendChild(innerTraceXML(child,depth-1));
               }
            }
         } else {
            spriteXML = <dispObj name={dispObj.name} x={dispObj.x} y={dispObj.y} height={dispObj.height} width={dispObj.width} scaleX={sp.scaleX} scaleY={sp.scaleY} scale9Grid={sp.scale9Grid} />;
         }
         return spriteXML;
      }
   }
}