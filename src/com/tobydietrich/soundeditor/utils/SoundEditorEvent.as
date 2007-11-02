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
 /** 
  * Contains events that happen to the playhead
  */
package com.tobydietrich.soundeditor.utils
{
   import flash.events.Event;

   public class SoundEditorEvent extends Event
   {
      // the events that can fire.
      // change: changes in the playstate
      public static var PLAYABLE_CHANGE:String = "PLAYABLE_CHANGE";
      // progress: progress of the playhead.
      public static var PLAYABLE_PROGRESS:String = "PLAYABLE_PROGRESS";
      
      public static var SPECTRUM_PROGRESS:String = "SPECTRUM_PROGRESS";
      
      public static var CUE_POINT_SELECT_NEW:String = "CUE_POINT_SELECT_NEW";
      
      public static var CUE_POINT_UPDATE:String = "CUE_POINT_UPDATE";
      
      public static var FILMSTRIP_MODEL_LOADED:String = "FILMSTRIP_MODEL_LOADED";
      
      public static var MOUSE_OVER_SPRITE:String = "MOUSE_OVER_SPRITE";
      
      public var data:XML = null;

      public function SoundEditorEvent(type:String, bubbles:Boolean=false,
      cancelable:Boolean=false, data:XML = null)
      {
         super(type, bubbles, cancelable);
         this.data = data;
      }

   }
}