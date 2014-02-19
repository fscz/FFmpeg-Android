package com.appunite.ffmpeg.audio;

public abstract class Decoder {
	
	static {
		System.loadLibrary("ffmpeg");
		System.loadLibrary("ffmpeg-jni");
	}
	
	protected native void startDecodingNative(DataFeed feed);
}
