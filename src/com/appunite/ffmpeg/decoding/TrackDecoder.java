package com.appunite.ffmpeg.decoding;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import android.media.AudioTrack;
import android.util.Log;

public class TrackDecoder extends Decoder {
	
	public static final String TAG = "TrackDecoder";
	
	static {
		System.loadLibrary("ffmpeg");
		System.loadLibrary("ffmpeg-jni");
	}
	
	private DataFeed decodeFeed = null;
	private AudioTrack track = null;
	private volatile boolean running = false;
	
	public TrackDecoder(InputStream in, AudioTrack track) {
		this.track = track;
		this.decodeFeed = new DecodeFeed(in);
	}
	
	private class DecodeFeed implements DataFeed {
		private InputStream in;
		private OutputStream out;
		
		private DecodeFeed(InputStream in) {
			this.in = in;
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
//			StringBuffer sb = new StringBuffer();
//			for (int i = 0; i < length - 2*2 +1; i+=2) {
//				sb.append(" "+(0xff00 & (buffer[i+1] << 8) | (0xff & buffer[i]))+"\t");
//			}
//			Log.i(TAG, sb.toString());
			if (!running) return -1;
			try {
				if (track != null) track.write(buffer, 0, length);
				else {
					out.write(buffer, 0, length);
					out.flush();
				}
				return 0;
			} catch (Exception e) {
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
}
