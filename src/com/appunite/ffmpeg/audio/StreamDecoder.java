package com.appunite.ffmpeg.audio;

import java.io.IOException;
import java.io.InputStream;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class StreamDecoder extends Decoder {
	
	public static final String TAG = "StreamDecoder";
	
	private final Mutex _mutex = new Mutex(); 
	private final ExecutorService writeThread = Executors.newSingleThreadExecutor();
	private IOStream out = null;
	private DataFeed decodeFeed = null;
	
	private volatile boolean running = false;
	
	public StreamDecoder(InputStream in) throws IOException {
		this.out = new IOStream();
		this.decodeFeed = new DecodeFeed(in, this.out);
	}
	
	private class DecodeFeed implements DataFeed {
		private InputStream in;
		private IOStream out;
		
		private DecodeFeed(InputStream in, IOStream out) {
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
			_mutex.lock();
			writeThread.submit(new Runnable() {
				@Override
				public void run() {
					try {
						out.write(buffer, 0, length);
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
	
	public IOStream getPcmStream() {
		return this.out;
	}
}
