#ifndef H_AUDIOCONVERTER
#define H_AUDIOCONVERTER

#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libswresample/swresample.h>

/****************
 * TYPES
 */
typedef struct {
	JNIEnv* env;
	jbyteArray readBuffer;
	jbyteArray writeBuffer;
	jobject feed;
	jclass feed_class;
	jmethodID read;
	jmethodID write;
	jmethodID start;
	jmethodID stop;
} JNIContext;

typedef struct {
	JNIContext* jnictx;
	AVCodecContext* codecctx;
	AVFrame* frame;
	AVPacket* pkt;
	SwrContext** swr;
	int (* write_func)(JNIContext* jnictx, uint8_t* buffer, int length);
	int dst_nb_samples;
	int dst_nb_channels;
	int dst_sample_rate;
	int dst_line_size;
	int max_dst_nb_samples;
	uint8_t** dst_samples;
} AudioDecoderCtx;

typedef struct SwrContext SwrContext;


/****************
 * FUNCTIONS
 */
void jni_audio_converter_start_decoding(JNIEnv *env, jobject thiz, jobject encoderDataFeed);


/****************
 * VALUES
 */
JNIContext global_ctx;
static char *audio_decoder_class_path_name = "com/appunite/ffmpeg/decoding/Decoder";
static JNINativeMethod audio_decoder_methods[] = {
	{"startDecodingNative", "(Lcom/appunite/ffmpeg/decoding/DataFeed;)V", (void*) jni_audio_converter_start_decoding},
};

#endif
