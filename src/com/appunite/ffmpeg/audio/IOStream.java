package com.appunite.ffmpeg.audio;

import java.io.IOException;
import java.io.InputStream;

public class IOStream extends InputStream {
	
	public static final String TAG = "IOStream";
	
	private Buffer local_buffer = null;
	
	
	int write_pos = 0;
	
	public IOStream() throws IOException {
		local_buffer = new Buffer();
	}
	
	/**
	 * 
	 * @param size_in_kb defaults to 16 with default constructor
	 */
	public IOStream(final int size_in_kb) {
		local_buffer = new Buffer(size_in_kb);
	}
	
	@Override
	public void close() throws IOException{
		local_buffer.close();
	}
	
	@Override
	public int read() throws IOException {
		return local_buffer.read();
	}
	
	@Override
	public int read(byte[] buffer) throws IOException {
		return local_buffer.read(buffer);
	}
	
	
	@Override
	public int read(byte[] buffer, int offset, int bytes) throws IOException {
		return local_buffer.read(buffer, offset, bytes);
	}
	
	public int write(byte[] buffer) throws IOException {
		return local_buffer.write(buffer);
	}
	
	public int write(final byte[] buffer, final int offset, final int bytes) throws IOException {
		return local_buffer.write(buffer, offset, bytes);
	}
	
	
	
}
