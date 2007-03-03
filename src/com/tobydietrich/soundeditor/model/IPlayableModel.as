/***
 * A model of something that is playable
 */
 package com.tobydietrich.soundeditor.model
{
	public interface IPlayableModel
	{
		function get fractionComplete():Number;
		
		// I can't really do this without incorporating player functions
		//function set fractionComplete(fraction:Number):void;
			
		function get playing():Boolean;
		
		function get paused():Boolean;
		
		function get stopped():Boolean;
		
		function get atBeginning():Boolean;
		
		function get atEnd():Boolean;
		
		function get playState():int;
		
		function set playState( newState:int ):void;

        function get playPosition():int;
        
        function set playPosition( newPosition:int):void;
	}
}