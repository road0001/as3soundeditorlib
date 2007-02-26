package com.tobydietrich.soundeditor.player
{
	public interface Playable
	{
		function rewindAll():void;
		
		function forwardAll():void;
		
		function play():void;
		
		function pause():void;
		
		function stop():void;
		
		function get fractionComplete():Number;
		
		function set fractionComplete(x:Number):void;
		
		function synchronize(p:Playable):void;
		
		function get playing():Boolean;
		
		function get paused():Boolean;
		
		function get stopped():Boolean;
		
		function get atBeginning():Boolean;
		
		function get atEnd():Boolean;
		
		function get playState():int;

        function get playPosition():int;
	}
}