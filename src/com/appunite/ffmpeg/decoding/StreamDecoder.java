package com.appunite.ffmpeg.decoding;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PipedInputStream;
import java.io.PipedOutputStream;

public class StreamDecoder extends Decoder {
	
	public static final String TAG = "StreamDecoder";
	
	static {
		System.loadLibrary("ffmpeg");
		System.loadLibrary("ffmpeg-jni");
	}
	
	private InputStream out = null;
	private DataFeed decodeFeed = null;
	
	private volatile boolean running = false;
	
	public StreamDecoder(InputStream in) throws IOException {
		PipedOutputStream pipe = new PipedOutputStream();
		this.out = new PipedInputStream(pipe);
		this.decodeFeed = new DecodeFeed(in, pipe);
	}
	
	private class DecodeFeed implements DataFeed {
		private InputStream in;
		private OutputStream out;
		
		private DecodeFeed(InputStream in, OutputStream out) {
			this.in = in;
			this.out = out;
		}
		
		public void stop() {
			if (!running) return;
			running = false;
			try {
				if (out != null) {
					out.close();
				}
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
		}
		
		public void start() {
			if (!running) return;
		}
		
		public int read(byte[] buffer) {
			if (! running) return -1; // tell native code, we are done
			try {
				return in.read(buffer);
			} catch (IOException e) {
				stopDecoding();
				return -1; // tell native code, we are done
			}
		}
		
		public int write(final byte[] buffer, final int length) {
			if (!running) return -1;
			try {
				out.write(buffer, 0, length);
				out.flush();
				return 0;
			} catch (IOException e) {
				stopDecoding();
				return -1;
			}
		}
	}
	
	public void startDecoding() {
		if (running) return;
		running = true;
		new Thread(new Runnable() {
			@Override
			public void run() {
				startDecodingNative(decodeFeed);
			}
		}).start();
	}
	
	public void stopDecoding() {
		if (!running) return;
		running = false;
	}
	
	public InputStream getPcmStream() {
		return this.out;
	}
}
