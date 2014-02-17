package com.appunite.ffmpeg.decoding;

public abstract class Decoder {
	protected native void startDecodingNative(DataFeed feed);
}
