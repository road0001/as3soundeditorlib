package com.tobydietrich.soundeditor.test
{
	import com.tobydietrich.soundeditor.model.SoundLoaderModel;
	import com.tobydietrich.soundeditor.model.SoundModel;
	
	import flash.events.*;
	import flash.utils.*;
	
	import flexunit.framework.*;
	

	public class SoundModelTest extends TestCase
	{
		private const TIMEOUT:int = 30000;
		private var soundModel:SoundModel;
		private var t:Timer;
		
		public function SoundModelTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testSoundModel():void {
			
			var loader:SoundLoaderModel = new SoundLoaderModel("sound", 
				"http://localhost/audeto/data/firstMVT2006/sound.mp3");
			loader.addEventListener(Event.COMPLETE, addAsync(eLoadComplete,TIMEOUT));
		}		
		
		private function eLoadComplete(event:Event):void {
				soundModel = new SoundModel(event.target.sound);
				var hint:String = '1';
				// assert stop
				assertTrue(hint + ": not at start", soundModel.atStart);
				assertFalse(hint + ": at end ", soundModel.atEnd);
				assertTrue(hint + ": not stopped", soundModel.stopped);
				assertFalse(hint + ": playing", soundModel.playing);
				assertFalse(hint + ": paused", soundModel.paused);
				assertTrue(hint + ": position is not 0", soundModel.position == 0);
				
				// start playing
				soundModel.play(true);
				t = new Timer(3000);
				t.start();
				t.addEventListener(TimerEvent.TIMER, addAsync(eTest1, TIMEOUT));
		}
		
		private function eTest1(event:Event):void {
			t.stop();
			var hint:String = '1';
			// assert play
			assertFalse(hint + ": at start", soundModel.atStart);
			assertFalse(hint + ": at end ", soundModel.atEnd);
			assertFalse(hint + ": stopped", soundModel.stopped);
			assertTrue(hint + ": not playing", soundModel.playing);
			assertFalse(hint + ": paused", soundModel.paused);
			assertFalse(hint + ": position is 0", soundModel.position == 0);
			
			soundModel.play(false);
			hint = '1';
			// assert pause
			assertFalse(hint + ": at start", soundModel.atStart);
			assertFalse(hint + ": at end ", soundModel.atEnd);
			assertFalse(hint + ": stopped", soundModel.stopped);
			assertFalse(hint + ": playing", soundModel.playing);
			assertTrue(hint + ": not paused", soundModel.paused);
			assertFalse(hint + ": position is 0", soundModel.position == 0);
			
			soundModel.stop();
			hint = '3';
			// assert stop
			assertTrue(hint + ": not at start", soundModel.atStart);
			assertFalse(hint + ": at end ", soundModel.atEnd);
			assertTrue(hint + ": not stopped", soundModel.stopped);
			assertFalse(hint + ": playing", soundModel.playing);
			assertFalse(hint + ": paused", soundModel.paused);
			assertTrue(hint + ": position is not 0", soundModel.position == 0);
			
			soundModel.position = 1200;
			hint = '2';
			// assert pause
			assertFalse(hint + ": at start", soundModel.atStart);
			assertFalse(hint + ": at end ", soundModel.atEnd);
			assertFalse(hint + ": stopped", soundModel.stopped);
			assertFalse(hint + ": playing", soundModel.playing);
			assertTrue(hint + ": not paused", soundModel.paused);
			assertFalse(hint + ": position is 0", soundModel.position == 0);
			
			soundModel.stop();
			hint = '3';
			// assert stop
			assertTrue(hint + ": not at start", soundModel.atStart);
			assertFalse(hint + ": at end ", soundModel.atEnd);
			assertTrue(hint + ": not stopped", soundModel.stopped);
			assertFalse(hint + ": playing", soundModel.playing);
			assertFalse(hint + ": paused", soundModel.paused);
			assertTrue(hint + ": position is not 0", soundModel.position == 0);
			
			soundModel.play(true);
			t = new Timer(3000);
			t.start();
			t.addEventListener(TimerEvent.TIMER, addAsync(eTest2, TIMEOUT));
		}	
		private  function eTest2(event:Event):void {
			t.stop();
			var hint:String = '2';
			// assert play
			assertFalse(hint + ": at start", soundModel.atStart);
			assertFalse(hint + ": at end ", soundModel.atEnd);
			assertFalse(hint + ": stopped", soundModel.stopped);
			assertTrue(hint + ": not playing", soundModel.playing);
			assertFalse(hint + ": paused", soundModel.paused);
			assertFalse(hint + ": position is 0", soundModel.position == 0);
			
			soundModel.position = 1300;
			hint = '3';
			// assert play
			assertFalse(hint + ": at start", soundModel.atStart);
			assertFalse(hint + ": at end ", soundModel.atEnd);
			assertFalse(hint + ": stopped", soundModel.stopped);
			assertTrue(hint + ": not playing", soundModel.playing);
			assertFalse(hint + ": paused", soundModel.paused);
			assertFalse(hint + ": position is 0", soundModel.position == 0);
			
			soundModel.stop();
			hint = '4';
			// assert stop
			assertTrue(hint + ": not at start", soundModel.atStart);
			assertFalse(hint + ": at end ", soundModel.atEnd);
			assertTrue(hint + ": not stopped", soundModel.stopped);
			assertFalse(hint + ": playing", soundModel.playing);
			assertFalse(hint + ": paused", soundModel.paused);
			assertTrue(hint + ": position is not 0", soundModel.position == 0);
		}
	}
}