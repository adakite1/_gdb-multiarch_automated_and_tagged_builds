#!/usr/bin/env bash

# Compile libGMP
mkdir -p /tmp/build/gmp && cd /tmp/build/gmp && \
	"/tmp/src/gmp-${GMP_VERSION}/configure" \
		--prefix=/tmp/install/gmp \
		--enable-static \
		--disable-shared
cd /tmp/build/gmp && make "-j${CPU_CORES}"
cd /tmp/build/gmp && make install

# Compile libMPFR
mkdir -p /tmp/build/mpfr && cd /tmp/build/mpfr && \
	"/tmp/src/mpfr-${MPFR_VERSION}/configure" \
		--prefix=/tmp/install/mpfr \
		--with-gmp=/tmp/install/gmp \
		--enable-static \
		--disable-shared
cd /tmp/build/mpfr && make "-j${CPU_CORES}"
cd /tmp/build/mpfr && make install

# Compile libexpat
mkdir -p /tmp/build/expat && cd /tmp/build/expat && \
	"/tmp/src/expat-${EXPAT_VERSION}/configure" \
		--prefix=/tmp/install/expat \
		--enable-static \
		--disable-shared
cd /tmp/build/expat && make "-j${CPU_CORES}"
cd /tmp/build/expat && make install

# Compile GDB
mkdir -p /tmp/build/gdb && cd /tmp/build/gdb && \
	CFLAGS="-O2 -g" CXXFLAGS="-O2 -g" \
	"/tmp/src/gdb-${GDB_VERSION}/configure" \
		--prefix=/tmp/install/gdb \
		--enable-targets=all \
		--target=arm-none-eabi \
		--with-gmp=/tmp/install/gmp \
		--with-mpfr=/tmp/install/mpfr \
		--with-expat \
		--with-libexpat-prefix=/tmp/install/expat \
		--enable-static \
		--disable-shared \
		--disable-gold \
		--disable-sim \
		--disable-werror \
		--disable-pgo-build \
		--without-guile \
		--without-python \
		--with-zstd=no \
		--with-lzma=no \
		--enable-threading
cd /tmp/build/gdb && make "-j${CPU_CORES}"
cd /tmp/build/gdb && make install

# Copy the GDB executables from the built files and strip away debug symbols to reduce the filesize
mkdir /tmp/dist && \
	cp /tmp/install/gdb/bin/arm-none-eabi-gdb /tmp/dist/gdb && \
	strip /tmp/dist/gdb

