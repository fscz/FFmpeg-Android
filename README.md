FFmpeg-Android
==============

A videoplayer, streaming audioplayer and streaming audio decoder that outputs pcm or directly writes to Android/AudioTrack (based on https://github.com/appunite/AndroidFFmpeg)

Used Sources
==============
- trunk ffmpeg (https://github.com/FFmpeg/FFmpeg) / 17.02.2014
- v1.3.4 libvorbis (https://github.com/TechSmith/libvorbis) 
- v1.3.1 libogg (http://xiph.org/ogg/) 
- v2.5.2 freetype (http://download.savannah.gnu.org/releases/freetype/)
- last x264 (http://www.videolan.org/developers/x264.html) / 17.02.2014 / disabled by default for licensing reasons
- trunk libass (https://github.com/libass/libass) / 17.02.2014
 

Building
==============
1. checkout the project
2. cd <project-dir>/jni
3. export NDK=/path/to/android-ndk-version8 (If you want to compile with another NDK you are on your own)
4. ./build_android
5. ndk-build

Repeat steps 4 and 5 after making changes to the source 


Usage
==============
- It is an Android Library Project so you can import it into ADT and reference it
from other projects
- Check classes in com.appunite.ffmpeg.audio
- TrackDecoder accepts an InputStream (some audio format) and an Android AudioTrack and will write pcm data directly to the AudioTrack
- StreamDecoder is a convenience class and accepts an InputStream and return an InputStream of PCM data. This is achieved by using the com.appunite.ffmpeg.audio.Buffer class (see there for details). Using this class should be sufficient (performance-wise) for tasks like writing pcm data to a file or some simple audio processing. If you want to add more heavy lifting to the audio processing pipeline, you should subclass com.appunite.ffmpeg.audio.Decoder and thus avoid some of the copying and shifting that Buffer has to do. Check StreamDecoder/TrackDecoder to see, how you can do that.


Examples
==============
- AudioPlayer audioPlayer = new AudioPlayer(new FileInputStream("/path/to/your/mp3file"));
- audioPlayer.play();
- audioPlayer.stop();
- for more fine grained control of audio decoding, check the classes in com.appunite.ffmpeg.audio
- see an example for using FFmpegPlayer at https://github.com/appunite/AndroidFFmpeg

