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
      public static function traceXML(dispObj:DisplayObject):XML {
         var temp:XML = innerTraceXML(dispObj);

         return new XML('<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
         + temp.toXMLString());
      }

      private static function innerTraceXML(dispObj:DisplayObject):XML {
         var spriteXML:XML;
         if(dispObj is DisplayObjectContainer) {
            var sp:DisplayObjectContainer = dispObj as DisplayObjectContainer;
            if(sp is LabelSprite) {
               var ls:LabelSprite = sp as LabelSprite;
               spriteXML = <sprite label={ls.label} x={ls.x} y={ls.y} height={ls.height} width={ls.width} />;
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