/**
 * Loads a cue XML file and signals the Audeto class.
 */
package com.tobydietrich.soundeditor.sound
{
   import flash.display.Sprite;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.events.*;
   import flash.utils.Timer;
   import flash.geom.Rectangle;
   import flash.display.Shape;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFieldAutoSize;
   import flash.media.Sound;
   import flash.media.SoundChannel;

   public class CueXML
   {
      private var myParent:SoundClient;

      // stores the CueXML file
      public var xmlCue:XML = new XML();

      // how many cue points are there?
      public var numCuePoints:int;

      // check if the inputs are loaded.
      private var xmlCueIsLoaded:Boolean = false;

      public function CueXML(parent:SoundClient, xmlCue_URL:String) {
         myParent = parent;

         var xmlCueURL:URLRequest = new URLRequest(xmlCue_URL);
         var cueLoader:URLLoader = new URLLoader(xmlCueURL);
         cueLoader.addEventListener(Event.COMPLETE, xmlCueLoaded);
         cueLoader.addEventListener(ProgressEvent.PROGRESS, checkCueLoadProgress);
         cueLoader.addEventListener(IOErrorEvent.IO_ERROR, cueIoErrorHandler);
      }

      public function get isLoaded():Boolean {
         return xmlCueIsLoaded;
      }

      // call when the CueXML is loaded
      private function xmlCueLoaded(event:Event):void {
         var loader:URLLoader = URLLoader(event.target);
         xmlCue = XML(loader.data);
         //trace("Cue Data loaded.");
         xmlCueIsLoaded = true;
         myParent.checkForCompletion();
      }
      
      public function cueIoErrorHandler(event:Event):void {
         trace("Cue ioErrorHandler: " + event);
      }
      

      public function checkCueLoadProgress(event:ProgressEvent):void {
         var nLoaded:Number = event.bytesLoaded;
         var nTotal:Number = event.bytesTotal;
         var nFraction:Number = 0;
         if (nTotal>0) {
            nFraction = nLoaded/nTotal;
         }
        myParent.cueLoaderProgress = nFraction;
      }
      
      private function get endCueTime():int { 
      	var measure:XML = getMeasureFromCueName('End'); 
		if (measure == null) throw new Error('Cue XML does not obey dtd');
		else return int(measure.Time);
      }
      
      private function get lastMeasure():XML {
      	var max_elt:XML = null;
      	var elt:XML = null;
      	for each(elt in xmlCue.CuePoint) {
      		if(!isNaN(Number(elt.Name))) {
	      		if(max_elt == null) { 
	      		   max_elt = elt; 
	      		} else if(int(max_elt.Time) < int(elt.Time)) {
	      				max_elt = elt;
	      		}
      		}
      	}
        return max_elt;
      }
      
      /**
      * Given the start time, get the current measure
      */
      private function getMeasureFromTime(time:int):XML { 
      	// the value is simply the last time that is less than the given time.
      	var myList:XMLList = xmlCue.CuePoint.(Time <= time);
      	var elt:XML = null;
      	for each(elt in myList) {
      		;
      	}
      	return elt;
      }
      
      /**
      * Given the measure number, get the measure information
      */
      private function getMeasureFromMeasureNumber(num:int):XML {
      	//trace('this function is deprecated: there may be more than one such measure');
      	var myList:XMLList = xmlCue.CuePoint.(Name == num.toString());
      	var elt:XML = null;
      	for each(elt in myList) {
      		return elt;
      	}
      	return null;
      }
      
            
      /**
      * Given the measure number, get the measure information
      */
      private function getMeasureFromCueName(name:String):XML {
      	var myList:XMLList = xmlCue.CuePoint.(Name == name);
      	var elt:XML = null;
      	for each(elt in myList) {
      		return elt;
      	}
      	return null;
      }
      
      /**
      * Given the measure number, get the start time in milliseconds of the measure
      */
      private function getMeasureStartTimeFromMeasureNumber(num:int):int {
      	var m:XML = getMeasureFromMeasureNumber(num);
      	return (m == null) ? 0 : m.Time;
      }
      
      /**
      * Get the number of milliseconds into the current measure we are
      */
      public function getMeasureOffsetFromTime(time:int):int { 
      	var t:int = time - getMeasureStartTimeFromTime(time);
      	if(t < 0) {
      		throw new Error ('offset t is less than 0');
      	} else {
      		return t;
      	}
      }
      
      /**
      *  get the duration in milliseconds of the curernt measure
      */
      public function getMeasureDurationFromTime(time:int):int {
      	var measure:XML = getMeasureFromMeasureNumber(getMeasureNumberFromTime(time)+1);
      	var nextTime:int = (measure == null) ? endCueTime : int(measure.Time);
      	var t:int = nextTime - getMeasureStartTimeFromTime(time);
      	if(t < 0) {
      		throw new Error ('duration t is less than 0');
      	} else {
      		return t;
      	}
      }
      
      /**
      * get the time in milliseconds at which the measure starts
      */
      public function getMeasureStartTimeFromTime(time:int):int { 
      	var m:XML = getMeasureFromTime(time);
      	return (m == null) ? 0 :
      	   ((m.Name == 'End') ? 
      	      ((lastMeasure == null) ? 0 : int(lastMeasure.Time)) : int(m.Time));
      }
      
      /**
      * get the number of the current measure.
      */
      public function getMeasureNumberFromTime(time:int):int {
      	var m:XML = getMeasureFromTime(time);
      	return (m == null) ? 0 : ((m.Name=='End')?  
      	  ((lastMeasure == null) ? 0 : int(lastMeasure.Name)) : int(m.Name));
      }
   }
}