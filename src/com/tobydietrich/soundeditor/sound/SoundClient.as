package com.audeto.as3soundeditorlib.sound
{
	public interface SoundClient
	{
		function checkForCompletion():void;
		
		function set cueLoaderProgress(fraction:Number):void;
		
		function get cueLoaderProgress():Number;
		
		function set sndLoaderProgress(fraction:Number):void;
		
		function get sndLoaderProgress():Number;
		
		function stop():void;
	}
}