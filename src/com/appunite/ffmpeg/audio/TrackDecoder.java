package com.appunite.ffmpeg.audio;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import android.media.AudioTrack;

public class TrackDecoder extends Decoder {
	
	public static final String TAG = "TrackDecoder";
	
	private final Mutex _mutex = new Mutex();
	private final ExecutorService writeThread = Executors.newSingleThreadExecutor();
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
			_mutex.lock();
			if (!running) return -1;
			writeThread.submit(new Runnable() {
				
				@Override
				public void run() {
					try {
						if (track != null) track.write(buffer, 0, length);
						else {
							out.write(buffer, 0, length);
							out.flush();
						}
					} catch (Exception e) {
						stopDecoding();
					}	
					_mutex.unlock();
				}
			});
			return 0;
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
