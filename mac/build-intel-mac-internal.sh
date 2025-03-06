#!/usr/bin/env bash

# Compile libGMP
mkdir -p /tmp/build/gmp && cd /tmp/build/gmp && \
	CFLAGS="-arch x86_64" CXXFLAGS="-arch x86_64" \
	"/tmp/src/gmp-${GMP_VERSION}/configure" \
		--prefix=/tmp/install/gmp \
        --build=x86_64-apple-darwin \
        --host=x86_64-apple-darwin \
		--enable-static \
		--disable-shared
cd /tmp/build/gmp && make "-j${CPU_CORES}"
cd /tmp/build/gmp && make install

# Compile libMPFR
mkdir -p /tmp/build/mpfr && cd /tmp/build/mpfr && \
	CFLAGS="-arch x86_64" CXXFLAGS="-arch x86_64" \
	"/tmp/src/mpfr-${MPFR_VERSION}/configure" \
		--prefix=/tmp/install/mpfr \
        --build=x86_64-apple-darwin \
        --host=x86_64-apple-darwin \
		--with-gmp=/tmp/install/gmp \
		--enable-static \
		--disable-shared
cd /tmp/build/mpfr && make "-j${CPU_CORES}"
cd /tmp/build/mpfr && make install

# Compile GDB
mkdir -p /tmp/build/gdb && cd /tmp/build/gdb && \
	CFLAGS="-O2 -g -arch x86_64" CXXFLAGS="-O2 -g -arch x86_64" \
	"/tmp/src/gdb-${GDB_VERSION}/configure" \
		--prefix=/tmp/install/gdb \
        --build=x86_64-apple-darwin \
        --host=x86_64-apple-darwin \
		--enable-targets=all \
		--target=arm-none-eabi \
		--with-gmp=/tmp/install/gmp \
		--with-mpfr=/tmp/install/mpfr \
		--with-static-standard-libraries \
		--enable-static \
		--disable-shared \
		--disable-ld \
		--disable-gold \
		--disable-sim \
		--disable-werror \
		--disable-pgo-build \
		--without-guile \
		--without-python
cd /tmp/build/gdb && make "-j${CPU_CORES}"
cd /tmp/build/gdb && make install

# Copy the GDB executables from the built files and strip away debug symbols to reduce the filesize
mkdir /tmp/dist && \
	cp /tmp/install/gdb/bin/arm-none-eabi-gdb /tmp/dist/gdb && \
	strip /tmp/dist/gdb

