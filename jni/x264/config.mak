SRCPATH=.
prefix=/Users/fschuetz/Dropbox/devel/android/FFMpeg/jni/x264/../ffmpeg-build/x86
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
libdir=${exec_prefix}/lib
includedir=${prefix}/include
ARCH=X86
SYS=LINUX
CC=/opt/android-ndk-r8e//toolchains/x86-4.4.3/prebuilt/darwin-x86_64/bin/i686-linux-android-gcc --sysroot=/opt/android-ndk-r8e//platforms/android-9/arch-x86/
CFLAGS=-Wshadow -O3 -ffast-math -m32 -Wall -I. -I$(SRCPATH) -std=gnu99 -fomit-frame-pointer -fno-tree-vectorize
DEPMM=-MM -g0
DEPMT=-MT
LD=/opt/android-ndk-r8e//toolchains/x86-4.4.3/prebuilt/darwin-x86_64/bin/i686-linux-android-gcc --sysroot=/opt/android-ndk-r8e//platforms/android-9/arch-x86/ -o 
LDFLAGS=-Wl,-rpath-link=/opt/android-ndk-r8e//platforms/android-9/arch-x86//usr/lib -L/opt/android-ndk-r8e//platforms/android-9/arch-x86//usr/lib  -lc -lm -ldl -llog -lm -ldl
LIBX264=libx264.a
AR=/opt/android-ndk-r8e//toolchains/x86-4.4.3/prebuilt/darwin-x86_64/bin/i686-linux-android-ar rc 
RANLIB=/opt/android-ndk-r8e//toolchains/x86-4.4.3/prebuilt/darwin-x86_64/bin/i686-linux-android-ranlib
STRIP=/opt/android-ndk-r8e//toolchains/x86-4.4.3/prebuilt/darwin-x86_64/bin/i686-linux-android-strip
INSTALL=install
AS=
ASFLAGS= -DHAVE_ALIGNED_STACK=1 -DHIGH_BIT_DEPTH=0 -DBIT_DEPTH=8
RC=
RCFLAGS=
EXE=
HAVE_GETOPT_LONG=1
DEVNULL=/dev/null
PROF_GEN_CC=-fprofile-generate
PROF_GEN_LD=-fprofile-generate
PROF_USE_CC=-fprofile-use
PROF_USE_LD=-fprofile-use
HAVE_OPENCL=yes
default: cli
install: install-cli
default: lib-static
install: install-lib-static
LDFLAGSCLI = -ldl 
CLI_LIBX264 = $(LIBX264)
