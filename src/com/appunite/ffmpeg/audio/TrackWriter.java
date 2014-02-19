package com.appunite.ffmpeg.audio;

import java.io.IOException;
import java.io.InputStream;

import android.media.AudioTrack;

public class TrackWriter extends Thread {
	private InputStream in;
	private AudioTrack out;
	private int bytes = 0;
	private byte[] buffer;
	public TrackWriter(InputStream in, AudioTrack out) {
		this.in = in;
		this.out = out;
		this.setDaemon(true);
		this.buffer = new byte[1024];
	}
	@Override
	public void run() {
		try {
			while ((bytes = in.read(buffer)) != -1) {
				if (out == null || out.getPlayState() == AudioTrack.PLAYSTATE_STOPPED) break;
				if (bytes > 1) out.write(buffer, 0, bytes);
			}
		} catch (IOException io) {
			io.printStackTrace();
		}
		try {
			in.close();
		} catch (IOException e) {}
	}
}
