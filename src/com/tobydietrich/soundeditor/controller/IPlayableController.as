/***
 * A controller for something that is playable.
 */
package com.tobydietrich.soundeditor.controller
{
	public interface IPlayableController
	{
	    function rewindAll():void;
		
		function forwardAll():void;
		
		function play():void;
		
		function pause():void;
		
		function stop():void;
		
		function set fractionComplete(x:Number):void;
	}
}