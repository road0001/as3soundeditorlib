package com.tobydietrich.soundeditor.test
{
	import com.tobydietrich.soundeditor.model.CuePointModel;
	import flexunit.framework.TestCase;
	
	
	public class CuePointModelTest extends TestCase
	{
		public static var xml1:XML = 
<FLVCoreCuePoints Version="1">
  
  <CuePoint>
    <Time>0</Time>
    <Type>event</Type>
    <Name>1</Name>
  </CuePoint>

  <CuePoint>
    <Time>1296</Time>
    <Type>event</Type>
    <Name>2</Name>
  </CuePoint>

  <CuePoint>
    <Time>2489</Time>
    <Type>event</Type>
    <Name>3</Name>
  </CuePoint>

  <CuePoint>
    <Time>3682</Time>
    <Type>event</Type>
    <Name>4</Name>
  </CuePoint>

  <CuePoint>
    <Time>4943</Time>
    <Type>event</Type>
    <Name>5</Name>
  </CuePoint>

  <CuePoint>
    <Time>6171</Time>
    <Type>event</Type>
    <Name>6</Name>
  </CuePoint>

  <CuePoint>
    <Time>7329</Time>
    <Type>event</Type>
    <Name>7</Name>
  </CuePoint>

  <CuePoint>
    <Time>8533</Time>
    <Type>event</Type>
    <Name>8</Name>
  </CuePoint>

  <CuePoint>
    <Time>9749</Time>
    <Type>event</Type>
    <Name>9</Name>
  </CuePoint>

  <CuePoint>
    <Time>10977</Time>
    <Type>event</Type>
    <Name>10</Name>
  </CuePoint>

  <CuePoint>
    <Time>12215</Time>
    <Type>event</Type>
    <Name>End</Name>
  </CuePoint>

</FLVCoreCuePoints>; 
		
			public static var xml2:XML = 
<FLVCoreCuePoints Version="1">
  
  <CuePoint>
    <Time>0</Time>
    <Type>event</Type>
    <Name>1</Name>
  </CuePoint>

  <CuePoint>
    <Time>1296</Time>
    <Type>event</Type>
    <Name>2</Name>
  </CuePoint>

  <CuePoint>
    <Time>2489</Time>
    <Type>event</Type>
    <Name>3</Name>
  </CuePoint>

  <CuePoint>
    <Time>3682</Time>
    <Type>event</Type>
    <Name>4</Name>
  </CuePoint>

  <CuePoint>
    <Time>4943</Time>
    <Type>event</Type>
    <Name>5</Name>
  </CuePoint>

  <CuePoint>
    <Time>6171</Time>
    <Type>event</Type>
    <Name>6</Name>
  </CuePoint>

  <CuePoint>
    <Time>7329</Time>
    <Type>event</Type>
    <Name>7</Name>
  </CuePoint>

  <CuePoint>
    <Time>8533</Time>
    <Type>event</Type>
    <Name>8</Name>
  </CuePoint>

  <CuePoint>
    <Time>9749</Time>
    <Type>event</Type>
    <Name>9</Name>
  </CuePoint>

  <CuePoint>
    <Time>10977</Time>
    <Type>event</Type>
    <Name>10</Name>
  </CuePoint>
  
  <CuePoint>
    <Time>51000</Time>
    <Type>event</Type>
    <Name>54</Name>
  </CuePoint>
  
    <CuePoint>
    <Time>182000</Time>
    <Type>event</Type>
    <Name>88</Name>
  </CuePoint>

    <CuePoint>
    <Time>182001</Time>
    <Type>event</Type>
    <Name>End</Name>
  </CuePoint>

</FLVCoreCuePoints>;

public static var xml3:XML = 
<FLVCoreCuePoints Version="1">
  
  <CuePoint>
    <Time>0</Time>
    <Type>event</Type>
    <Name>1</Name>
  </CuePoint>

  <CuePoint>
    <Time>1000</Time>
    <Type>event</Type>
    <Name>2</Name>
  </CuePoint>

  <CuePoint>
    <Time>2000</Time>
    <Type>event</Type>
    <Name>3</Name>
  </CuePoint>

  <CuePoint>
    <Time>3000</Time>
    <Type>event</Type>
    <Name>4</Name>
  </CuePoint>

  <CuePoint>
    <Time>4000</Time>
    <Type>event</Type>
    <Name>5</Name>
  </CuePoint>

  <CuePoint>
    <Time>5000</Time>
    <Type>event</Type>
    <Name>6</Name>
  </CuePoint>

  <CuePoint>
    <Time>6000</Time>
    <Type>event</Type>
    <Name>7</Name>
  </CuePoint>

  <CuePoint>
    <Time>7000</Time>
    <Type>event</Type>
    <Name>8</Name>
  </CuePoint>

  <CuePoint>
    <Time>8000</Time>
    <Type>event</Type>
    <Name>9</Name>
  </CuePoint>

  <CuePoint>
    <Time>9000</Time>
    <Type>event</Type>
    <Name>10</Name>
  </CuePoint>
  
  <CuePoint>
    <Time>53000</Time>
    <Type>event</Type>
    <Name>54</Name>
  </CuePoint>
  
    <CuePoint>
    <Time>87000</Time>
    <Type>event</Type>
    <Name>88</Name>
  </CuePoint>

    <CuePoint>
    <Time>88000</Time>
    <Type>event</Type>
    <Name>End</Name>
  </CuePoint>

</FLVCoreCuePoints>;

		private var cuePointModel1:CuePointModel = new CuePointModel(xml1);
		private var cuePointModel2:CuePointModel = new CuePointModel(xml2);
		private var cuePointModel3:CuePointModel = new CuePointModel(xml3);
		
		public function CuePointModelTest(methodName:String=null)
		{
			super(methodName);
		}
		public function testEndCuePoint():void {
			// model 1
			assertTrue(cuePointModel1.endCuePoint == <CuePoint>
			    <Time>12215</Time>
			    <Type>event</Type>
			    <Name>End</Name>
			  </CuePoint>);
			// model 2
			assertTrue(cuePointModel2.endCuePoint == <CuePoint>
			    <Time>182001</Time>
			    <Type>event</Type>
			    <Name>End</Name>
			  </CuePoint>);
			// model 3
			assertTrue(cuePointModel3.endCuePoint == <CuePoint>
			    <Time>88000</Time>
			    <Type>event</Type>
			    <Name>End</Name>
			  </CuePoint>);
		}
		public function testLastMeasure():void {
			// model 1
			assertTrue(cuePointModel1.lastMeasure == <CuePoint>
			    <Time>10977</Time>
			    <Type>event</Type>
			    <Name>10</Name>
			  </CuePoint>);
			// model 2
			assertTrue(cuePointModel2.lastMeasure == <CuePoint>
			    <Time>182000</Time>
			    <Type>event</Type>
			    <Name>88</Name>
			  </CuePoint>);
			// model 3
			assertTrue(cuePointModel3.lastMeasure == <CuePoint>
			    <Time>87000</Time>
			    <Type>event</Type>
			    <Name>88</Name>
			  </CuePoint>);
			
		}
		public function testGetMeasureOffsetFromTime():void {
			// model 1
			var model:CuePointModel = cuePointModel1;
			assertTrue( 8 == model.getMeasureOffsetFromTime(2497) );
			assertTrue( 0 == model.getMeasureOffsetFromTime(3682) );
		 	assertTrue( 111 == model.getMeasureOffsetFromTime(6171 + 111) );
		 	
		 	// model3
		 	model = cuePointModel3;
		 	assertTrue( 0 == model.getMeasureOffsetFromTime(9000) );
			assertTrue( 0 == model.getMeasureOffsetFromTime(80000) );
		 	
			for(var i:int = 0; i < 88; i++) {
				assertTrue( 0 == model.getMeasureOffsetFromTime(i * 1000) );
				assertTrue( 100 == model.getMeasureOffsetFromTime(i * 1000 + 100) );
			}
		}
		
		public function testGetMeasureDurationFromTime():void {
			// model 1
			var model:CuePointModel = cuePointModel1;
			assertTrue( (3682-2489) + " != " + model.getMeasureDurationFromTime(3300), 
				(3682-2489) == model.getMeasureDurationFromTime(3300) );
			assertTrue( " 1296 != " + model.getMeasureDurationFromTime(1000), 
				1296 == model.getMeasureDurationFromTime(1000) );
			
		 	// model3
		 	model = cuePointModel3;
			for(var i:int = 0; i < 88; i++) {
				assertTrue( "for " + i*1000 + ", 1000 != " + model.getMeasureDurationFromTime(i * 1000) + model.getMeasureFromTime(i * 1000),
					1000 == model.getMeasureDurationFromTime(i * 1000) );
				assertTrue( "for " + (i*1000+100) + ", 1000 != " + model.getMeasureDurationFromTime(i * 1000 + 100) + model.getMeasureFromTime(i * 1000 + 100), 
					1000 == model.getMeasureDurationFromTime(i * 1000 + 100) );
			}
		}
		
		public function testGetMeasureStartTimeFromTime():void {
			// model 1
			var model:CuePointModel = cuePointModel1;
			assertTrue( 0 + " == " + model.getMeasureStartTimeFromTime(100), 
				0 == model.getMeasureStartTimeFromTime(100) );
			assertTrue( 1296 + " == " + model.getMeasureStartTimeFromTime( 1296 ), 
				1296 == model.getMeasureStartTimeFromTime( 1296 ) );
			assertTrue( 1296 + " == " + model.getMeasureStartTimeFromTime( 1400 ), 
				1296 == model.getMeasureStartTimeFromTime( 1400 ) );
			

		 	// model3
		 	model = cuePointModel3;
			for(var i:int = 0; i < 88; i++) {
				assertTrue( i * 1000 + "!=" + model.getMeasureStartTimeFromTime(i * 1000) + model.getMeasureFromTime(i * 1000), 
					(i * 1000) == model.getMeasureStartTimeFromTime(i * 1000) );
				assertTrue( i * 1000 + "!=" + model.getMeasureStartTimeFromTime(i * 1000 + 100) + model.getMeasureFromTime(i * 1000 + 100),
					(i * 1000) == model.getMeasureStartTimeFromTime(i * 1000 + 100) );
			}
		}
		
		public function testGetMeasureNumberFromTime():void {
			// model 1
			var model:CuePointModel = cuePointModel1;
			assertTrue( "1 != " + model.getMeasureNumberFromTime(100) + model.getMeasureFromTime(100), 
				1 == model.getMeasureNumberFromTime(100) );
			assertTrue( "3 != " + model.getMeasureNumberFromTime( 3000 ) + model.getMeasureFromTime(3000),
				3 == model.getMeasureNumberFromTime( 3000 ) );
		 	assertTrue( "6 != " + model.getMeasureNumberFromTime( 7000 ) + model.getMeasureFromTime(7000), 
		 		6 == model.getMeasureNumberFromTime( 7000 ) );
		 	assertTrue( " 4 != " + model.getMeasureNumberFromTime( 3682 ) + model.getMeasureFromTime(3682), 
		 		4 == model.getMeasureNumberFromTime( 3682 ) );

		 	// model3
		 	model = cuePointModel3;
			for(var i:int = 0; i < 88; i++) {
				assertTrue( i + " != " + model.getMeasureNumberFromTime(i * 1000) + model.getMeasureFromTime(i * 1000), 
					(i+1) == model.getMeasureNumberFromTime(i * 1000) );
				assertTrue( i + " 1= " + model.getMeasureNumberFromTime(i * 1000 + 100) + model.getMeasureFromTime(i * 1000 + 100),
					(i+1) == model.getMeasureNumberFromTime(i * 1000 + 100) );
				assertTrue( i + " != " + model.getMeasureNumberFromTime(i * 1000 + 999) + model.getMeasureFromTime(i * 1000 + 999),
					(i+1) == model.getMeasureNumberFromTime(i * 1000 + 999) );
			}
		}
		
		public function testSelectedCuePoint():void {
			// model 1
			var model:CuePointModel = cuePointModel1;
			model.selectedCuePoint = model.xml.CuePoint.(Name == '1')[0];
			assertTrue( model.selectedCuePoint == model.xml.CuePoint.(Name == '1')[0]);
		}
		
		public function testNumCuePoints():void {
			// model 1
			var model:CuePointModel = cuePointModel1;
			assertTrue( 11 == model.numCuePoints );
			
			// model 2
			model = cuePointModel2;
			assertTrue( 13 == model.numCuePoints );
		}
	}
}