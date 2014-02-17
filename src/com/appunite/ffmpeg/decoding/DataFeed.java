package com.appunite.ffmpeg.decoding;

public interface DataFeed {
	public void start();
	public void stop();
	public int read(byte[] buffer);
	public int write(byte[] buffer, int length);
}
