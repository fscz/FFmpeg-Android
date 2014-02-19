package com.appunite.ffmpeg.audio;

import java.io.IOException;

public class Buffer {
	
	public static final String TAG = "Buffer";
	
	private Object _mutex = new Object();
	private Mutex _read_mutex = new Mutex();
	private Mutex _write_mutex = new Mutex();
	private byte[][] local_buffer = null;
	private int local_buffer_size = 0;
	private int mx_local_bufer_size = 0;
	private int chunk_size = 1024;
	private int nb_chunks = 16;
	
	int write_pos = 0;
	private volatile boolean done = false;
	
	/**
	 * Threadable Buffer class that may be written to and read from
	 * - buffer size defaults to 16kb
	 * - read-methods block, if not enough data is available
	 * - write methods block, if buffer is full
	 * - flush is a noop
	 * - close will cause future read/writes to be noops, returning -1 
	 */
	public Buffer() {
		init();
	}
	
	/**
	 * Default constructor sets buffersize to 16 kb
	 * @param size_in_kb set buffersize as desired
	 */
	public Buffer(final int size_in_kb) {
		this.nb_chunks = size_in_kb;
		init();
	}
	
	private void init() {
		local_buffer = new byte[nb_chunks][chunk_size];
		mx_local_bufer_size = nb_chunks * chunk_size;
	}
	
	public void flush() {
		// Can't really do much here. In case a read/write thread is
		// waiting, it will be poked as soon as possible anyways.
		// It could be argued, that flush() should cause the 
		// cache to be emptied before accepting new writes,
		// however this seems impractical and unnecessary.
		// For what it's worth, this method is provided for the
		// case, where an subclass of Buffer wants to use it. 
	}
	
	public void close() throws IOException{
		synchronized (_mutex) {
			done = true;
			_mutex.notifyAll();
		}
	}
	
	public int read() throws IOException {
		byte[] buffer = new byte[1];
		read(buffer);
		return buffer[0];
	}
	
	public int read(byte[] buffer) throws IOException {
		return read(buffer, 0, buffer.length);
	}
	
	public int read(byte[] buffer, int offset, int bytes) throws IOException {
		synchronized (_mutex) {
			_read_mutex.lock();
			int bytes_read = 0;
			try {
				// block while not enough data is available
				while (local_buffer_size < bytes + offset && !done) {
					try {
						_mutex.wait();
					} catch (InterruptedException e) {}
				}
				if (done) return -1;
				
				int pos = offset;
				
				for (int i = 0; i < bytes && pos < local_buffer_size; pos++, i++) {
					buffer[i] = local_buffer[pos / chunk_size][pos % chunk_size];
				}
				
				bytes_read = Math.min(bytes, pos - offset);
				
				// left shift
				for (int i = 0, j = bytes_read + offset; j < local_buffer_size; i++, j++) {
					local_buffer[i / chunk_size][i % chunk_size] = 
							local_buffer[j / chunk_size][j % chunk_size];
				}
				
				return bytes_read;
			} finally {
				local_buffer_size -= (bytes_read);
				write_pos -= (bytes_read + offset);
				_mutex.notify(); // write() might be waiting until more space is available, so notify
				_read_mutex.unlock();
			}
		}
	}
	
	public int write(final byte[] buffer) throws IOException {
		return write(buffer, 0, buffer.length);
	}
	
	public int write(final byte[] buffer, final int offset, final int bytes) throws IOException {
		synchronized (_mutex) {
			_write_mutex.lock();
			try {
				// block while not enough room in the local_buffer
				while (local_buffer_size + bytes + offset > mx_local_bufer_size) {
					try {
						_mutex.wait();
					} catch (InterruptedException e) {}
				}
				if (done) return -1;
				
				write_pos += offset;
				for (int i = 0; i < bytes; write_pos++, i++) {
					local_buffer[write_pos / chunk_size][write_pos % chunk_size]
							= buffer[i];
				}
				
				return bytes;
			} finally {
				local_buffer_size += bytes;
				_mutex.notify(); // read() might be waiting for input, so notify
				_write_mutex.unlock();
			}
		}	
	}
}
