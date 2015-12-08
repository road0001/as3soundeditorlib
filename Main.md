# Introduction #

The sound editor library will provide a graphical representation of sound file, and enable the user to navigate around the sound file and define cue points. The cue points will be exportable to XML.


# Details #

I need a flash component that allows a user to define cue points for an MP3 file. Thus, I am working on this.

The graph is of time (x-axis) versus volume (y-axis, with the right channel above the axis and the left channel below). I am obtaining the volume from a playing SoundChannel. My first attempt to speed up the drawing will be to draw several different intervals in parallel (i.e. several different SoundChannels). It would be nice to generate the graph without using the sound playing functionality. I do not want to make external calls, since I want the flash application to be standalone.

# Contact #

Charles Dietrich
http://www.charlesdietrich.com/contact