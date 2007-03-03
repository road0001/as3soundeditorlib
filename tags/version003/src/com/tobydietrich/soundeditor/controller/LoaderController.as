package com.tobydietrich.soundeditor.controller
{
	import com.tobydietrich.soundeditor.utils.PrototypeError;
	import flash.events.EventDispatcher;
	
	public class LoaderController extends EventDispatcher
	{
		public function get name():String {
			throw new PrototypeError();
		}
		
		public function get fractionLoaded():Number {
			throw new PrototypeError();
		}
		
	}
}