package com.appunite.ffmpeg.audio;

public interface DataFeed {
	public void start();
	public void stop();
	public int read(byte[] buffer);
	public int write(byte[] buffer, int length);
}
