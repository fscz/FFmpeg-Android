FFmpeg-Android
==============

A videoplayer and streaming audio decoder that outputs pcm or directly writes to Android/AudioTrack (based on https://github.com/appunite/AndroidFFmpeg)

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


Using
==============
It is an Android Library Project so you can import it into ADT and reference it
from other projects.
