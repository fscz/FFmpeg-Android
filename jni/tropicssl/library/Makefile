
# Also see "include/tropicssl/config.h"

CFLAGS	= -I../include -D_FILE_OFFSET_BITS=64 -Wall -Werror
OFLAGS	= -O2

# MicroBlaze specific options:
# CFLAGS += -mno-xl-soft-mul -mxl-barrel-shift

# To compile on Plan9:
# CFLAGS += -D_BSD_EXTENSION

# To compile as a shared library:
# CFLAGS += -fPIC

DLEXT=so
# OSX shared library extension:
# DLEXT=dylib

OBJS=	aes.o		arc4.o		base64.o	\
	bignum.o	certs.o		debug.o		\
	des.o		dhm.o		havege.o	\
	md2.o		md4.o		md5.o		\
	net.o		padlock.o	rsa.o		\
	sha1.o		sha2.o		sha4.o		\
	ssl_cli.o	ssl_srv.o	ssl_tls.o	\
	timing.o	x509parse.o	xtea.o		\
	camellia.o

.SILENT:

all: static

static: libtropicssl.a

shared: libtropicssl.$(DLEXT)

libtropicssl.a: $(OBJS)
	echo "  AR    $@"
	ar r $@ $(OBJS)
	echo "  RL    $@"
	ranlib $@

libtropicssl.so: libtropicssl.a
	echo "  LD    $@"
	$(CC) -shared -Wl,-soname,$@ -o $@ $(OBJS)

libtropicssl.dylib: libtropicssl.a
	echo "  LD    $@"
	$(CC) -dynamiclib -o $@ $(OBJS)

.c.o:
	echo "  CC    $<"
	$(CC) $(CFLAGS) $(OFLAGS) -c $<

clean:
	rm -f *.o libtropicssl.*

