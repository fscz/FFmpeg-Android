package com.appunite.ffmpeg.audio;

import android.media.AudioFormat;
import android.media.AudioManager;
import android.media.AudioTrack;
import android.util.Log;

public class TrackHandler {
	
	public static final String TAG = "AudioHandler";
	
	public static final int sample_rate_default = 44100;
	public static final int channel_count_default = 2;
	
	public static AudioTrack makeDefaultAudioTrack() {
		int bufferSize = 4*AudioTrack.getMinBufferSize(sample_rate_default,
        		AudioFormat.CHANNEL_OUT_STEREO,
        		AudioFormat.ENCODING_PCM_16BIT);
		
		final AudioTrack track = new AudioTrack(AudioManager.STREAM_MUSIC, 
				sample_rate_default, 
				AudioFormat.CHANNEL_OUT_STEREO, 
				AudioFormat.ENCODING_PCM_16BIT, 
				bufferSize, 
				AudioTrack.MODE_STREAM);
		return track;
	}
	
	public static AudioTrack makeToneTrack(final int hz, final int seconds) {
		final byte[] samples_for_one_second = new byte[2*sample_rate_default];
		final AudioTrack track = makeDefaultAudioTrack();
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				double incr = (2 * Math.PI * hz) / (double)sample_rate_default;
				double pos = 0;
				short tmp;
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < seconds; i++) {
					for (int j = 0; j < samples_for_one_second.length - channel_count_default*2 + 1; 
							j+=(channel_count_default*2)) {
						tmp = (short)(Math.sin(pos) * 32767);
						sb.append(" "+tmp+"\t");
						samples_for_one_second[j] = (byte) (0x00ff & tmp);
						samples_for_one_second[j+1] = (byte) ((0xff00 & tmp) >>> 8);
						for (int k = 1; k < channel_count_default; k++) {
							samples_for_one_second[j+(2*k)] = samples_for_one_second[j];
							samples_for_one_second[j+(2*k)+1] = samples_for_one_second[j+1];
						}
						pos = (pos + incr) % (2*Math.PI * hz);
					}
					track.write(samples_for_one_second, 0, samples_for_one_second.length);
				}
				Log.i(TAG, sb.toString());
			}
		}).start();
		return track;
	}
}
