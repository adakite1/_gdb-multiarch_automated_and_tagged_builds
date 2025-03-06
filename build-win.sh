#!/usr/bin/env bash

# Install MinGW-w64
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    mingw-w64 \
    mingw-w64-tools

# Cross-compile libGMP for Windows with MinGW-w64
mkdir -p /tmp/build/gmp && cd /tmp/build/gmp && \
	CC_FOR_BUILD="x86_64-linux-gnu-gcc" \
    CPP_FOR_BUILD="x86_64-linux-gnu-cpp" \
	"/tmp/src/gmp-${GMP_VERSION}/configure" \
		--prefix=/tmp/install/gmp \
		--host=x86_64-w64-mingw32 \
		--enable-static \
		--disable-shared
cd /tmp/build/gmp && make "-j${CPU_CORES}"
cd /tmp/build/gmp && make install

# Cross-compile libMPFR for Windows with MinGW-w64
mkdir -p /tmp/build/mpfr && cd /tmp/build/mpfr && \
	CC_FOR_BUILD="x86_64-linux-gnu-gcc" \
	CPP_FOR_BUILD="x86_64-linux-gnu-cpp" \
	"/tmp/src/mpfr-${MPFR_VERSION}/configure" \
		--prefix=/tmp/install/mpfr \
		--with-gmp=/tmp/install/gmp \
		--host=x86_64-w64-mingw32 \
		--enable-static \
		--disable-shared
cd /tmp/build/mpfr && make "-j${CPU_CORES}"
cd /tmp/build/mpfr && make install

# Cross-compile GDB for Windows with MinGW-w64, enabling multi-architecture support for debugging both Windows and Linux target applications
# (See:
# - https://stackoverflow.com/a/61363144
# - https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=gdb-multiarch
# - https://github.com/msys2/MINGW-packages/blob/master/mingw-w64-gdb/PKGBUILD)
mkdir -p /tmp/build/gdb && cd /tmp/build/gdb && \
	CFLAGS="-O2 -g" CXXFLAGS="-O2 -g" \
	CC_FOR_BUILD="x86_64-linux-gnu-gcc" \
	CPP_FOR_BUILD="x86_64-linux-gnu-cpp" \
	"/tmp/src/gdb-${GDB_VERSION}/configure" \
		--prefix=/tmp/install/gdb \
		--host=x86_64-w64-mingw32 \
		--target=x86_64-w64-mingw32 \
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
	cp /tmp/install/gdb/bin/gdb.exe /tmp/dist/gdb.exe && \
	cp /tmp/install/gdb/bin/gdbserver.exe /tmp/dist/gdbserver.exe && \
	strip -s /tmp/dist/gdb.exe && \
	strip -s /tmp/dist/gdbserver.exe

