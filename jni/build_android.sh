#!/bin/bash
#
# build_android.sh
# Copyright (c) 2012 Jacek Marchwicki
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [ "$NDK" = "" ]; then
	echo NDK variable not set, exiting
	echo "Use: export NDK=/your/path/to/android-ndk"
	exit 1
fi

OS=`uname -s | tr '[A-Z]' '[a-z]'`
function build_x264
{
	PLATFORM=$NDK/platforms/$PLATFORM_VERSION/arch-$ARCH/
	export PATH=${PATH}:$PREBUILT/bin/
	CROSS_COMPILE=$PREBUILT/bin/$EABIARCH-
	CFLAGS=$OPTIMIZE_CFLAGS
#CFLAGS=" -I$ARM_INC -fpic -DANDROID -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__  -Wno-psabi -march=armv5te -mtune=xscale -msoft-float -mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -DANDROID  -Wa,--noexecstack -MMD -MP "
	export CPPFLAGS="$CFLAGS"
	export CFLAGS="$CFLAGS"
	export CXXFLAGS="$CFLAGS"
	export CXX="${CROSS_COMPILE}g++ --sysroot=$PLATFORM"
	export AS="${CROSS_COMPILE}gcc --sysroot=$PLATFORM"
	export CC="${CROSS_COMPILE}gcc --sysroot=$PLATFORM"
	export NM="${CROSS_COMPILE}nm"
	export STRIP="${CROSS_COMPILE}strip"
	export RANLIB="${CROSS_COMPILE}ranlib"
	export AR="${CROSS_COMPILE}ar"
	export LDFLAGS="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib  -lc -lm -ldl -llog"

	cd x264
	./configure --prefix=$(pwd)/$PREFIX --host=$ARCH-linux --enable-static $ADDITIONAL_CONFIGURE_FLAG || exit 1

	make clean || exit 1
	make -j4 install || exit 1
	cd ..
}

function build_ogg
{
    PLATFORM=$NDK/platforms/$PLATFORM_VERSION/arch-$ARCH/
	export PATH=${PATH}:$PREBUILT/bin/
	CROSS_COMPILE=$PREBUILT/bin/$EABIARCH-
	CFLAGS=$OPTIMIZE_CFLAGS
#CFLAGS=" -I$ARM_INC -fpic -DANDROID -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__  -Wno-psabi -march=armv5te -mtune=xscale -msoft-float -mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -DANDROID  -Wa,--noexecstack -MMD -MP "
	export CPPFLAGS="$CFLAGS"
	export CFLAGS="$CFLAGS -lgcc"
	export CXXFLAGS="$CFLAGS"
	export CXX="${CROSS_COMPILE}g++ --sysroot=$PLATFORM"
	export CC="${CROSS_COMPILE}gcc --sysroot=$PLATFORM"
	export NM="${CROSS_COMPILE}nm"
	export STRIP="${CROSS_COMPILE}strip"
	export RANLIB="${CROSS_COMPILE}ranlib"
	export AR="${CROSS_COMPILE}ar"
	export LDFLAGS="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -lc -lm -ldl -llog"

	cd libogg
	./autogen.sh \
	    --prefix=$(pwd)/$PREFIX \
	    --host=$ARCH-linux \
	    --disable-dependency-tracking \
	    --disable-shared \
	    --enable-static \
	    --with-pic \
	    $ADDITIONAL_CONFIGURE_FLAG \
        || exit 1

	make clean || exit 1
	make -j4 install || exit 1
	cd ..
}


function build_vorbis
{
    PLATFORM=$NDK/platforms/$PLATFORM_VERSION/arch-$ARCH/
	export PATH=${PATH}:$PREBUILT/bin/
	CROSS_COMPILE=$PREBUILT/bin/$EABIARCH-
	CFLAGS=$OPTIMIZE_CFLAGS
#CFLAGS=" -I$ARM_INC -fpic -DANDROID -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__  -Wno-psabi -march=armv5te -mtune=xscale -msoft-float -mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -DANDROID  -Wa,--noexecstack -MMD -MP "
	export CPPFLAGS="$CFLAGS"
	export CFLAGS="$CFLAGS -lgcc"
	export CXXFLAGS="$CFLAGS"
	export CXX="${CROSS_COMPILE}g++ --sysroot=$PLATFORM"
	export CC="${CROSS_COMPILE}gcc --sysroot=$PLATFORM"
	export NM="${CROSS_COMPILE}nm"
	export STRIP="${CROSS_COMPILE}strip"
	export RANLIB="${CROSS_COMPILE}ranlib"
	export AR="${CROSS_COMPILE}ar"
	export LDFLAGS="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -lc -lm -ldl -llog"

	cd libvorbis
	./configure \
        --with-ogg=$(pwd)/ffmpeg-build \
	    --prefix=$(pwd)/$PREFIX \
	    --host=$ARCH-linux \
	    --disable-dependency-tracking \
	    --disable-shared \
        --enable-static \
	    --with-pic \
	    $ADDITIONAL_CONFIGURE_FLAG \
	    || exit 1

	make clean || exit 1
	make -j4 install || exit 1
	cd ..
}

function build_amr
{
	PLATFORM=$NDK/platforms/$PLATFORM_VERSION/arch-$ARCH/
	export PATH=${PATH}:$PREBUILT/bin/
	CROSS_COMPILE=$PREBUILT/bin/$EABIARCH-
	CFLAGS=$OPTIMIZE_CFLAGS
#CFLAGS=" -I$ARM_INC -fpic -DANDROID -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__  -Wno-psabi -march=armv5te -mtune=xscale -msoft-float -mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -DANDROID  -Wa,--noexecstack -MMD -MP "
	export CPPFLAGS="$CFLAGS"
	export CFLAGS="$CFLAGS"
	export CXXFLAGS="$CFLAGS"
	export CXX="${CROSS_COMPILE}g++ --sysroot=$PLATFORM"
	export CC="${CROSS_COMPILE}gcc --sysroot=$PLATFORM"
	export NM="${CROSS_COMPILE}nm"
	export STRIP="${CROSS_COMPILE}strip"
	export RANLIB="${CROSS_COMPILE}ranlib"
	export AR="${CROSS_COMPILE}ar"
	export LDFLAGS="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog"

	cd vo-amrwbenc
	./configure \
	    --prefix=$(pwd)/$PREFIX \
	    --host=$ARCH-linux \
	    --disable-dependency-tracking \
	    --disable-shared \
	    --enable-static \
	    --with-pic \
	    $ADDITIONAL_CONFIGURE_FLAG \
	    || exit 1

	make clean || exit 1
	make -j4 install || exit 1
	cd ..
}

function build_aac
{
	PLATFORM=$NDK/platforms/$PLATFORM_VERSION/arch-$ARCH/
	export PATH=${PATH}:$PREBUILT/bin/
	CROSS_COMPILE=$PREBUILT/bin/$EABIARCH-
	CFLAGS=$OPTIMIZE_CFLAGS
#CFLAGS=" -I$ARM_INC -fpic -DANDROID -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__  -Wno-psabi -march=armv5te -mtune=xscale -msoft-float -mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -DANDROID  -Wa,--noexecstack -MMD -MP "
	export CPPFLAGS="$CFLAGS"
	export CFLAGS="$CFLAGS"
	export CXXFLAGS="$CFLAGS"
	export CXX="${CROSS_COMPILE}g++ --sysroot=$PLATFORM"
	export CC="${CROSS_COMPILE}gcc --sysroot=$PLATFORM"
	export NM="${CROSS_COMPILE}nm"
	export STRIP="${CROSS_COMPILE}strip"
	export RANLIB="${CROSS_COMPILE}ranlib"
	export AR="${CROSS_COMPILE}ar"
	export LDFLAGS="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog"

	cd vo-aacenc
	export PKG_CONFIG_LIBDIR=$(pwd)/$PREFIX/lib/pkgconfig/
	export PKG_CONFIG_PATH=$(pwd)/$PREFIX/lib/pkgconfig/
	./configure \
	    --prefix=$(pwd)/$PREFIX \
	    --host=$ARCH-linux \
	    --disable-dependency-tracking \
	    --disable-shared \
	    --enable-static \
	    --with-pic \
	    $ADDITIONAL_CONFIGURE_FLAG \
	    || exit 1

	make clean || exit 1
	make -j4 install || exit 1
	cd ..
}
function build_freetype2
{
	PLATFORM=$NDK/platforms/$PLATFORM_VERSION/arch-$ARCH/
	export PATH=${PATH}:$PREBUILT/bin/
	CROSS_COMPILE=$PREBUILT/bin/$EABIARCH-
	CFLAGS=$OPTIMIZE_CFLAGS
#CFLAGS=" -I$ARM_INC -fpic -DANDROID -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__  -Wno-psabi -march=armv5te -mtune=xscale -msoft-float -mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -DANDROID  -Wa,--noexecstack -MMD -MP "
	export CPPFLAGS="$CFLAGS"
	export CFLAGS="$CFLAGS"
	export CXXFLAGS="$CFLAGS"
	export CXX="${CROSS_COMPILE}g++ --sysroot=$PLATFORM"
	export CC="${CROSS_COMPILE}gcc --sysroot=$PLATFORM"
	export NM="${CROSS_COMPILE}nm"
	export STRIP="${CROSS_COMPILE}strip"
	export RANLIB="${CROSS_COMPILE}ranlib"
	export AR="${CROSS_COMPILE}ar"
	export LDFLAGS="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib  -lc -lm -ldl -llog"

	cd freetype2
	export PKG_CONFIG_LIBDIR=$(pwd)/$PREFIX/lib/pkgconfig/
	export PKG_CONFIG_PATH=$(pwd)/$PREFIX/lib/pkgconfig/
	./configure \
	    --prefix=$(pwd)/$PREFIX \
	    --host=$ARCH-linux \
	    --disable-dependency-tracking \
	    --disable-shared \
	    --enable-static \
	    --with-pic \
        --without-png \
	    $ADDITIONAL_CONFIGURE_FLAG \
	    || exit 1

	make clean || exit 1
	make -j4 install || exit 1
	cd ..
}
function build_ass
{
	PLATFORM=$NDK/platforms/$PLATFORM_VERSION/arch-$ARCH/
	export PATH=${PATH}:$PREBUILT/bin/
	CROSS_COMPILE=$PREBUILT/bin/$EABIARCH-
	CFLAGS="$OPTIMIZE_CFLAGS"
#CFLAGS=" -I$ARM_INC -fpic -DANDROID -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__  -Wno-psabi -march=armv5te -mtune=xscale -msoft-float -mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -DANDROID  -Wa,--noexecstack -MMD -MP "
	export CPPFLAGS="$CFLAGS"
	export CFLAGS="$CFLAGS"
	export CXXFLAGS="$CFLAGS"
	export CXX="${CROSS_COMPILE}g++ --sysroot=$PLATFORM"
	export CC="${CROSS_COMPILE}gcc --sysroot=$PLATFORM"
	export NM="${CROSS_COMPILE}nm"
	export STRIP="${CROSS_COMPILE}strip"
	export RANLIB="${CROSS_COMPILE}ranlib"
	export AR="${CROSS_COMPILE}ar"
	export LDFLAGS="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -lc -lm -ldl -llog"

	cd libass
	export PKG_CONFIG_LIBDIR=$(pwd)/$PREFIX/lib/pkgconfig/
	export PKG_CONFIG_PATH=$(pwd)/$PREFIX/lib/pkgconfig/
	./autogen.sh \
	    --prefix=$(pwd)/$PREFIX \
	    --host=$ARCH-linux \
	    --disable-fontconfig \
	    --disable-dependency-tracking \
	    --disable-shared \
	    --enable-static \
	    --with-pic \
	    $ADDITIONAL_CONFIGURE_FLAG \
	    || exit 1

    ./configure \
	    --prefix=$(pwd)/$PREFIX \
	    --host=$ARCH-linux \
	    --disable-fontconfig \
	    --disable-dependency-tracking \
	    --disable-shared \
	    --enable-static \
	    --with-pic \
	    $ADDITIONAL_CONFIGURE_FLAG \
	    || exit 1


	make clean || exit 1
	make V=1 -j4 install || exit 1
	cd ..
}
function build_fribidi
{
	PLATFORM=$NDK/platforms/$PLATFORM_VERSION/arch-$ARCH/
	export PATH=${PATH}:$PREBUILT/bin/
	CROSS_COMPILE=$PREBUILT/bin/$EABIARCH-
	CFLAGS="$OPTIMIZE_CFLAGS -std=gnu99"
#CFLAGS=" -I$ARM_INC -fpic -DANDROID -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__  -Wno-psabi -march=armv5te -mtune=xscale -msoft-float -mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -DANDROID  -Wa,--noexecstack -MMD -MP "
	export CPPFLAGS="$CFLAGS"
	export CFLAGS="$CFLAGS"
	export CXXFLAGS="$CFLAGS"
	export CXX="${CROSS_COMPILE}g++ --sysroot=$PLATFORM"
	export CC="${CROSS_COMPILE}gcc --sysroot=$PLATFORM"
	export NM="${CROSS_COMPILE}nm"
	export STRIP="${CROSS_COMPILE}strip"
	export RANLIB="${CROSS_COMPILE}ranlib"
	export AR="${CROSS_COMPILE}ar"
	export LDFLAGS="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog"

	cd fribidi
	./configure \
	    --prefix=$(pwd)/$PREFIX \
	    --host=$ARCH-linux \
	    --disable-bin \
	    --disable-dependency-tracking \
	    --disable-shared \
	    --enable-static \
	    --with-pic \
	    $ADDITIONAL_CONFIGURE_FLAG \
	    || exit 1

	make clean || exit 1
	make -j4 install || exit 1
	cd ..
}
function build_ffmpeg
{
	PLATFORM=$NDK/platforms/$PLATFORM_VERSION/arch-$ARCH/
	CC=$PREBUILT/bin/$EABIARCH-gcc
	CROSS_PREFIX=$PREBUILT/bin/$EABIARCH-
	PKG_CONFIG=${CROSS_PREFIX}pkg-config
	if [ ! -f $PKG_CONFIG ];
	then
		cat > $PKG_CONFIG << EOF
#!/bin/bash
pkg-config \$*
EOF
		chmod u+x $PKG_CONFIG
	fi
	NM=$PREBUILT/bin/$EABIARCH-nm
	cd ffmpeg
	export PKG_CONFIG_LIBDIR=$(pwd)/$PREFIX/lib/pkgconfig/
	export PKG_CONFIG_PATH=$(pwd)/$PREFIX/lib/pkgconfig/
	./configure --target-os=linux \
	    --prefix=$PREFIX \
	    --enable-cross-compile \
	    --extra-libs="-lgcc" \
	    --arch=$ARCH \
	    --cc=$CC \
	    --cross-prefix=$CROSS_PREFIX \
	    --nm=$NM \
	    --sysroot=$PLATFORM \
	    --extra-cflags=" -O3 -DANDROID -DHAVE_SYS_UIO_H=1 -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -finline-limit=300 $OPTIMIZE_CFLAGS " \
	    --disable-shared \
	    --enable-static \
	    --enable-runtime-cpudetect \
	    --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib  -nostdlib -lc -lm -ldl -llog -L$PREFIX/lib" \
	    --extra-cflags="-I$PREFIX/include" \
	    --disable-everything \
        --enable-libass \
	    --enable-libvo-aacenc \
	    --enable-libvo-amrwbenc \
        --enable-hwaccel=h264_vaapi \
        --enable-hwaccel=h264_vaapi \
        --enable-hwaccel=h264_dxva2 \
        --enable-hwaccel=mpeg4_vaapi \
        --enable-demuxer=ac3 \
        --enable-demuxer=flv \
	    --enable-demuxer=mov \
	    --enable-demuxer=h264 \
	    --enable-demuxer=mpegvideo \
	    --enable-demuxer=h263 \
	    --enable-demuxer=mpegps \
	    --enable-demuxer=mjpeg \
	    --enable-demuxer=rtsp \
	    --enable-demuxer=rtp \
	    --enable-demuxer=hls \
	    --enable-demuxer=matroska \
        --enable-demuxer=mp3 \
        --enable-demuxer=pcm_u16le \
        --enable-demuxer=pcm_s16le \
        --enable-demuxer=pcm_u16be \
        --enable-demuxer=pcm_s16be \
        --enable-demuxer=ogg \
        --enable-muxer=null \
	    --enable-muxer=mp2 \
        --enable-muxer=flv \
	    --enable-muxer=rtsp \
	    --enable-muxer=mp4 \
	    --enable-muxer=mov \
	    --enable-muxer=mjpeg \
	    --enable-muxer=matroska \
        --enable-muxer=wav \
        --enable-muxer=pcm_u16le \
        --enable-muxer=pcm_s16le \
        --enable-muxer=pcm_u16be \
        --enable-muxer=pcm_s16be \
        --enable-muxer=ogg \
        --enable-protocol=crypto \
	    --enable-protocol=file \
	    --enable-protocol=rtp \
	    --enable-protocol=tcp \
	    --enable-protocol=udp \
	    --enable-protocol=hls \
	    --enable-protocol=http \
        --enable-decoder=mp3 \
        --enable-decoder=flv \
	    --enable-decoder=xsub \
	    --enable-decoder=jacosub \
	    --enable-decoder=dvdsub \
	    --enable-decoder=dvbsub \
	    --enable-decoder=subviewer \
	    --enable-decoder=rawvideo \
        --enable-decoder=mjpeg \
        --enable-decoder=h263 \
	    --enable-decoder=mpeg4 \
        --enable-decoder=h264 \
        --enable-decoder=aac \
	    --enable-decoder=mp2 \
	    --enable-decoder=amrwb \
	    --enable-decoder=amrnb \
	    --enable-decoder=ac3 \
	    --enable-decoder=flac \
        --enable-decoder=pcm_u16le \
        --enable-decoder=pcm_s16le \
        --enable-decoder=pcm_u16be \
        --enable-decoder=pcm_s16be \
        --enable-encoder=flv \
	    --enable-encoder=rawvideo \
	    --enable-encoder=mjpeg \
	    --enable-encoder=mpeg4 \
	    --enable-encoder=aac \
	    --enable-encoder=mp2 \
        --enable-encoder=pcm_u16le \
        --enable-encoder=pcm_s16le \
        --enable-encoder=pcm_u16be \
        --enable-encoder=pcm_s16be \
	    --enable-encoder=libvo_amrwbenc \
        --enable-parsers \
	    --enable-parser=h264 \
        --enable-parser=h263 \
        --enable-parser=flac \
        --enable-parser=aac \
        --enable-parser=ac3 \
        --enable-parser=mpegaudio \
        --enable-parser=mpegvideo \
        --enable-parser=mpeg4video \
        --enable-bsfs \
        --enable-decoders \
        --enable-encoders \
	    --enable-hwaccels \
        --enable-muxers \
	    --enable-avformat \
	    --enable-avcodec \
	    --enable-avresample \
	    --enable-zlib \
        --disable-decoder=vorbis \
        --disable-encoder=vorbis \
	    --disable-doc \
	    --disable-ffplay \
	    --disable-ffmpeg \
	    --disable-ffplay \
	    --disable-ffprobe \
	    --disable-ffserver \
	    --disable-avfilter \
	    --disable-avdevice \
        --enable-libvorbis \
	    --enable-nonfree \
	    --enable-version3 \
	    --enable-memalign-hack \
	    --enable-asm \
        $ADDITIONAL_FFMPEG_FLAG \
	    $ADDITIONAL_CONFIGURE_FLAG \
	    || exit 1
	make clean || exit 1
	make -j4 install || exit 1

	cd ..
}

function build_one {
	cd ffmpeg
	PLATFORM=$NDK/platforms/$PLATFORM_VERSION/arch-$ARCH/
	$PREBUILT/bin/$EABIARCH-ld -rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -L$PREFIX/lib  -soname $SONAME -shared -nostdlib  -z noexecstack -Bsymbolic --whole-archive --no-undefined -o $OUT_LIBRARY -lavcodec -lavformat -lavresample -lavutil -lswresample -lass -lfreetype -lfribidi -lswscale -logg -lvorbis -lvorbisenc -lvo-aacenc -lvo-amrwbenc -lc -lm -lz -ldl -llog  --dynamic-linker=/system/bin/linker -zmuldefs $PREBUILT/lib/gcc/$EABIARCH/$NDK_TOOLCHAIN/libgcc.a || exit 1
	cd ..
}

function build_all {
    #build_x264
    build_ogg
    build_vorbis
    build_amr
    build_aac
    build_fribidi
    build_freetype2
    build_ass
    build_ffmpeg
    build_one
}



##GLOBAL
NDK_TOOLCHAIN=4.7
NDK_ARCH=darwin-x86_64


#x86
EABIARCH=i686-linux-android
ARCH=x86
OPTIMIZE_CFLAGS="-m32"
PREFIX=../ffmpeg-build/x86
OUT_LIBRARY=$PREFIX/libffmpeg.so
ADDITIONAL_CONFIGURE_FLAG="--disable-asm"
ADDITIONAL_FFMPEG_FLAG="--cpu=$CPU"
SONAME=libffmpeg.so
PREBUILT=$NDK/toolchains/x86-$NDK_TOOLCHAIN/prebuilt/$NDK_ARCH
PLATFORM_VERSION=android-9
build_all

#mips
EABIARCH=mipsel-linux-android
ARCH=mips
OPTIMIZE_CFLAGS="-EL -march=mips32 -mips32 -mhard-float"
PREFIX=../ffmpeg-build/mips
OUT_LIBRARY=$PREFIX/libffmpeg.so
ADDITIONAL_CONFIGURE_FLAG="--disable-mips32r2"
ADDITIONAL_FFMPEG_FLAG=
SONAME=libffmpeg.so
PREBUILT=$NDK/toolchains/mipsel-linux-android-$NDK_TOOLCHAIN/prebuilt/$NDK_ARCH
PLATFORM_VERSION=android-9
build_all

#arm v7vfpv3
EABIARCH=arm-linux-androideabi
ARCH=arm
CPU=armv7-a
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfpv3-d16 -marm -march=$CPU "
PREFIX=../ffmpeg-build/armeabi-v7a
OUT_LIBRARY=$PREFIX/libffmpeg.so
ADDITIONAL_CONFIGURE_FLAG=
ADDITIONAL_FFMPEG_FLAG="--cpu=$CPU"
SONAME=libffmpeg.so
PREBUILT=$NDK/toolchains/arm-linux-androideabi-$NDK_TOOLCHAIN/prebuilt/$NDK_ARCH
PLATFORM_VERSION=android-9
build_all

#arm v7 + neon (neon also include vfpv3-32)
EABIARCH=arm-linux-androideabi
ARCH=arm
CPU=armv7-a
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=neon -marm -march=$CPU -mtune=cortex-a8 -mthumb -D__thumb__ "
PREFIX=../ffmpeg-build/armeabi-v7a-neon
OUT_LIBRARY=../ffmpeg-build/armeabi-v7a/libffmpeg-neon.so
ADDITIONAL_CONFIGURE_FLAG="--enable-neon"
ADDITIONAL_FFMPEG_FLAG="--cpu=$CPU"
SONAME=libffmpeg-neon.so
PREBUILT=$NDK/toolchains/arm-linux-androideabi-$NDK_TOOLCHAIN/prebuilt/$NDK_ARCH
PLATFORM_VERSION=android-9
build_all
