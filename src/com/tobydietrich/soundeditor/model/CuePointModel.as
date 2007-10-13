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
 * This models a set of cue points
 */
package com.tobydietrich.soundeditor.model
{
	import com.tobydietrich.soundeditor.utils.SoundEditorEvent;
	
	import flash.events.EventDispatcher;
	
	/**
	 * The DTD is as follows:
	 * 1. you must have a last measure.
	 * 2. you must say when the music ends.
	 * Note that these can be populated from the MusicXML and mp3 respectively.
	 * Additionally, it may be necessary to have a 1st measure, I don't know
	 */
   public class CuePointModel extends EventDispatcher
   {
      // stores the set of cue points
      private var myXML:XML = new XML();

 	// which cue point is currently selected
      private var mySelectedCuePoint:XML;

	/**
	 * Creates a cue point model based on an XML file
	 */
      public function CuePointModel(m_xml:XML) {
		 myXML = m_xml;
      }
      
      /**
      * Gets the cue for the end of the piece
      */
      public function get endCuePoint():XML { 
      	return getFirst(myXML.CuePoint.(Name == 'End'));
      }
      
      /**
      * Gets the last cue point (e.g. the start of the last measure in the piece)
      */
      public function get lastMeasure():XML {
      	return getLast(numericMeasures.CuePoint);
      }
      
      /**
      * Given a time, get the most recent cue point (could be 'End')
      */
      private function getCuePointFromTime(time:int):XML { 
      	return getLast(myXML.CuePoint.(Time <= time));
      }
      
      /**
      * Given a measure number, gets the most recent cue point 
      */
      private function getCuePointFromMeasureNumber(measureNumber:int):XML {
      	return getLast(numericMeasures.CuePoint.(Name <= measureNumber));
      }
      
      /**
      * Given a time, get the cue point of the measure we are in
      */
      public function getMeasureFromTime(time:int):XML {
      	
      	var prevCuePoint:XML = getLast(numericMeasures.CuePoint.(Time <= time));
      	if(getTime(prevCuePoint) == time || prevCuePoint == lastMeasure) {
      		return prevCuePoint;
      	} else {
      		var nextCuePoint:XML = getFirst(numericMeasures.CuePoint.(Time > time));
      		var intervalMeasures:int = getMeasureNumber(nextCuePoint) - getMeasureNumber(prevCuePoint);
      		var intervalTime:int = getTime(nextCuePoint) - getTime(prevCuePoint);
      		var timePerMeasure:Number = intervalTime/intervalMeasures;
      		var myTimeOffset:int = time - getTime(prevCuePoint);
      		var elapsedMeasures:int = Math.floor(myTimeOffset/timePerMeasure);
      		var timeOfMeasure:int = Math.round(timePerMeasure*elapsedMeasures) + getTime(prevCuePoint);
      		var nameOfMeasure:int = getMeasureNumber(prevCuePoint) + elapsedMeasures;
      		return <CuePoint>
			    <Time>{timeOfMeasure}</Time>
			    <Type>event</Type>
			    <Name>{nameOfMeasure}</Name>
			  </CuePoint>;
      	}
      }
      
     
      /**
      * Given a measure number, get the cue point of that measure
      */
      public function getMeasureFromMeasureNumber(measureNumber:int):XML {
      	var prevCuePoint:XML = getLast(numericMeasures.CuePoint.(Name <= measureNumber));
      	if(getMeasureNumber(prevCuePoint) == measureNumber || prevCuePoint == lastMeasure) {
      		return prevCuePoint;
      	} else {
      		var nextCuePoint:XML = getFirst(numericMeasures.CuePoint.(Name > measureNumber));
      		var intervalMeasures:int = getMeasureNumber(nextCuePoint) - getMeasureNumber(prevCuePoint);
      		var intervalTime:int = getTime(nextCuePoint) - getTime(prevCuePoint);
      		var timePerMeasure:Number = intervalTime / intervalMeasures;
      		var myMeasureOffset:int = measureNumber - getMeasureNumber(prevCuePoint);
      		var timeOfMeasure:int = Math.floor(myMeasureOffset * timePerMeasure) + getTime(prevCuePoint);
      		return <CuePoint>
			    <Time>{timeOfMeasure}</Time>
			    <Type>event</Type>
			    <Name>{measureNumber}</Name>
			  </CuePoint>; 
			  
      	}
      }
      
      /**
      * Get the number of milliseconds into the current measure we are
      */
      public function getMeasureOffsetFromTime(time:int):int { 
      	return time - getMeasureStartTimeFromTime(time);
      }
      
      /**
      *  get the duration in milliseconds of the current measure
      */
      public function getMeasureDurationFromTime(time:int):int {
      	var currMeasure:XML = getMeasureFromTime(time);
      	if(currMeasure == lastMeasure) {
      		return getTime(endCuePoint) - getTime(currMeasure);
      	} else {
      		return getTime(getMeasureFromMeasureNumber(getMeasureNumber(currMeasure)+1))
      		 - getTime(currMeasure);
      	}
      }
      
      /**
      * get the time in milliseconds at which the measure starts
      */
      public function getMeasureStartTimeFromTime(time:int):int { 
      	return getTime(getMeasureFromTime(time));
      }
      
      /**
      * get the number of the current measure.
      */
      public function getMeasureNumberFromTime(time:int):int {
		return getMeasureNumber(getMeasureFromTime(time));
      }
      
      /**
      * Returns the normalized xml representation of this CuePointModel
      */
      public function get xml():XML {
      	return myXML;
      }
      
      /**
      * Sets the currently selected cue point
      */
      public function set selectedCuePoint(cuePoint:XML):void {
      	mySelectedCuePoint = cuePoint;
      	dispatchEvent(new SoundEditorEvent(SoundEditorEvent.CUE_POINT_SELECT_NEW));
      }
      
      /**
      * Gets the currently selected cue point
      */
      public function get selectedCuePoint():XML {
      	return mySelectedCuePoint;
      }
      
      /**
      * The Number of cue points defined
      */
      public function get numCuePoints():int {
      	return myXML.CuePoint.length();
      }
      /**
      * The number of measures the cue point xml thinks we have
      */
      private function get numMeasures():int {
    	return getMeasureNumber(lastMeasure);
      }
      
      private function getTime(m:XML):int {
      	return m.Time[0];
      }
      private function getName(m:XML):String {
      	return m.Name[0];
      }
      private function getMeasureNumber(m:XML):int {
      	return m.Name[0];
      }
      private function get numericMeasures():XML {
      	var retVal:XML = <FLVCoreCuePoints Version="1" />;
      	for each(var elt:XML in myXML.CuePoint) {
      		if(getName(elt) != 'End') {
      			retVal.appendChild(elt);
      		}
      	}
      	return retVal;
      }
      private function getLast(lst:XMLList):XML {
      	var elt:XML = null;
      	for each(elt in lst) {
      		;
      	}
      	return elt;
      }
      private function getFirst(lst:XMLList):XML {
      	var elt:XML = null;
      	for each(elt in lst) {
      		return elt;
      	}
      	return elt;
   	  }
	}
}