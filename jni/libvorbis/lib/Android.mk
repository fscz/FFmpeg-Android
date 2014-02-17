# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := libvorbis

LOCAL_C_INCLUDES := 	$(LOCAL_PATH)/../../libogg/include \
							$(LOCAL_PATH)/../include

LOCAL_SRC_FILES := \
	wav_ogg_file_codec_jni.c \
	encode_file.c \
	analysis.c \
	registry.c \
   vorbisenc.c \
   bitwise.c \
   framing.c \
   bitrate.c  \
   block.c  \
   codebook.c  \
   envelope.c  \
   floor0.c \
   floor1.c  \
   info.c  \
   lookup.c \
   lpc.c \
   lsp.c \
   mapping0.c \
   mdct.c \
   psy.c \
   res0.c \
   sharedbook.c \
   smallft.c \
   synthesis.c \
   vorbisfile.c \
   window.c 

#../lib/barkmel.c  \
#../lib/tone.c \
#../lib/psytune.c \

# include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)
