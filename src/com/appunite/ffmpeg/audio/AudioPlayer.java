package com.appunite.ffmpeg.audio;

import java.io.InputStream;

import android.media.AudioTrack;

public class AudioPlayer {
	private TrackDecoder decoder;
	private AudioTrack track;
	private boolean stopped = false;
	public AudioPlayer(InputStream in) {
		this.track = TrackHandler.makeDefaultAudioTrack();
		this.decoder = new TrackDecoder(in, track);
	}
	
	public void play() {
		 if (stopped)
			throw new IllegalStateException("Cannot call play, if already stopped or " +
					"illegally initialized");
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
