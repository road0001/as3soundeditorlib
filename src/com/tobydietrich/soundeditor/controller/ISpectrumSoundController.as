package com.tobydietrich.soundeditor.controller
{
	import com.tobydietrich.soundeditor.model.*;
	
	public interface ISpectrumSoundController extends IMediaController
	{
	   function get cueLoaderModel():XMLLoaderModel;
       function get spectrumSoundLoaderModel():SoundLoaderModel;
       function get spectrumModel():SpectrumModel;
       function get cuePointModel():CuePointModel;
       function getPeak(time:int):XML;
	}
}