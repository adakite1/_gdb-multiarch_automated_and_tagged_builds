#!/usr/bin/env zsh

# Set architecture flags for universal binary
export CFLAGS="-O2 -g -arch x86_64 -arch arm64"
export CXXFLAGS="-O2 -g -arch x86_64 -arch arm64"

# Compile libGMP
mkdir -p /tmp/build/gmp && cd /tmp/build/gmp && \
	"/tmp/src/gmp-${GMP_VERSION}/configure" \
		--prefix=/tmp/install/gmp \
		--enable-static \
		--disable-shared \
        --host=x86_64-apple-darwin
cd /tmp/build/gmp && make "-j${CPU_CORES}"
cd /tmp/build/gmp && make install

# Compile libMPFR
mkdir -p /tmp/build/mpfr && cd /tmp/build/mpfr && \
	CC_FOR_BUILD="x86_64-linux-gnu-gcc" \
	CPP_FOR_BUILD="x86_64-linux-gnu-cpp" \
	"/tmp/src/mpfr-${MPFR_VERSION}/configure" \
		--prefix=/tmp/install/mpfr \
		--with-gmp=/tmp/install/gmp \
		--enable-static \
		--disable-shared
cd /tmp/build/mpfr && make "-j${CPU_CORES}"
cd /tmp/build/mpfr && make install

# Compile GDB
mkdir -p /tmp/build/gdb && cd /tmp/build/gdb && \
	CFLAGS="-O2 -g" CXXFLAGS="-O2 -g" \
	CC_FOR_BUILD="x86_64-linux-gnu-gcc" \
	CPP_FOR_BUILD="x86_64-linux-gnu-cpp" \
	"/tmp/src/gdb-${GDB_VERSION}/configure" \
		--prefix=/tmp/install/gdb \
		--enable-targets=all \
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
	cp /tmp/install/gdb/bin/gdb /tmp/dist/gdb && \
	cp /tmp/install/gdb/bin/gdbserver /tmp/dist/gdbserver && \
	strip -s /tmp/dist/gdb && \
	strip -s /tmp/dist/gdbserver

