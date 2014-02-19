package com.appunite.ffmpeg.audio;

public class Mutex {
	private int mx_nb_resources = 1;
	private int nb_resources = 0;
	private final Object _mutex = new Object();
	
	/**
	 * Construct a mutex, where at max mx_nb_resources
	 * are allowed access
	 * @param mx_nb_resources defaults to 1 (using the default constructor)
	 */
	public Mutex(int mx_nb_resources) {
		this.mx_nb_resources = mx_nb_resources;
	}
	
	public Mutex() {}
	
	public void lock() {
		synchronized (_mutex) {
			nb_resources++;
			if (nb_resources > mx_nb_resources) {
				try {
					_mutex.wait();
				} catch (InterruptedException e) {}
			}
		}
	}
	
	public void unlock() {
		synchronized (_mutex) {
			nb_resources--;
			_mutex.notify();
		}
	}
}
