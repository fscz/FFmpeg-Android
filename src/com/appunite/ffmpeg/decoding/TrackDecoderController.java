package com.appunite.ffmpeg.decoding;

import java.io.InputStream;

import android.media.AudioTrack;

public class TrackDecoderController {
	private TrackDecoder decoder;
	private AudioTrack track;
	private boolean stopped = false;
	public TrackDecoderController(InputStream in) {
		this.track = TrackHandler.makeDefaultAudioTrack();
		this.decoder = new TrackDecoder(in, track);
	}
	
	public void start() {
		 if (stopped)
			throw new IllegalStateException("Cannot call start, if already released or illegally initialized");
		decoder.startDecoding();
		track.play();
	}
	
	public void stop() {
		stopped = true;
		track.stop();
		track.release();
		decoder.stopDecoding();
	}
}
