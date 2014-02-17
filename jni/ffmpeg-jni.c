/*
 * ffmpeg-jni.c
 * Copyright (c) 2012 Jacek Marchwicki
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

/*android specific headers*/
#include <jni.h>
#include <android/log.h>
/*standard library*/
#include <time.h>
#include <math.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <unistd.h>
#include <assert.h>


#include "helpers.h"
#include "player.h"
#include "audiodecoder.h"

/*for android logs*/
#define LOG_TAG "FFmpegTest"
#define LOG_LEVEL 10
#define LOGI(level, ...) if (level <= LOG_LEVEL) {__android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__);}
#define LOGE(level, ...) if (level <= LOG_LEVEL) {__android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__);}

#ifndef NELEM
#define NELEM(x) ((int)(sizeof(x) / sizeof((x)[0])))
#endif

static int register_native_methods(JNIEnv* env,
		const char* class_name,
		JNINativeMethod* methods,
		int num_methods)
{
	jclass clazz;


	clazz = (*env)->FindClass(env, class_name);
	if (clazz == NULL) {
		LOGE(1, "Native registration unable to find class '%s'\n",
				class_name);
		return JNI_FALSE;
	}
	if ((*env)->RegisterNatives(env, clazz, methods, num_methods) < 0) {
		LOGE(1, "RegisterNatives failed for '%s'\n", class_name);
		return JNI_FALSE;
	}

	return JNI_TRUE;
}

jint JNICALL JNI_OnLoad(JavaVM* vm, void* reserved)
{
	JNIEnv* env = NULL;
	jint result = -1;

	if ((*vm)->GetEnv(vm, (void**) &env, JNI_VERSION_1_4) != JNI_OK) {
		LOGE(1, "ERROR: GetEnv failed\n");
		goto bail;
	}
	assert(env != NULL);

	if (register_native_methods(env,
			player_class_path_name,
			player_methods,
			NELEM(player_methods)) < 0) {
		LOGE(1, "ERROR: register video_player methods failed\n");
		goto bail;
	}

	if (register_native_methods(env,
			audio_decoder_class_path_name,
			audio_decoder_methods,
			NELEM(audio_decoder_methods)) < 0) {
		LOGE(1, "ERROR: register audio_decoder methods failed\n");
		goto bail;
	}

	jclass encoderDataFeedClass = (*env)->FindClass(env, "com/appunite/ffmpeg/decoding/DataFeed");
	jmethodID readMethodId = (*env)->GetMethodID(env, encoderDataFeedClass, "read", "([B)I");
	jmethodID writeMethodId = (*env)->GetMethodID(env, encoderDataFeedClass, "write", "([BI)I");
	jmethodID startMethodId = (*env)->GetMethodID(env, encoderDataFeedClass, "start", "()V");
	jmethodID stopMethodId = (*env)->GetMethodID(env, encoderDataFeedClass, "stop", "()V");


	global_ctx.feed_class = encoderDataFeedClass;
	global_ctx.read = readMethodId;
	global_ctx.write = writeMethodId;
	global_ctx.start = startMethodId;
	global_ctx.stop = stopMethodId;

	/* success -- return valid version number */
	result = JNI_VERSION_1_4;

bail:
	return result;
}

void JNI_OnUnload(JavaVM *vm, void *reserved)
{
}


