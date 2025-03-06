#!/usr/bin/env bash

# Copy the license files for GDB and its dependencies
mkdir -p /tmp/dist/licenses/gdb && cp "/tmp/src/gdb-${GDB_VERSION}/COPYING" /tmp/dist/licenses/gdb/ && \
	mkdir -p /tmp/dist/licenses/gmp && cp "/tmp/src/gmp-${GMP_VERSION}/COPYING" /tmp/dist/licenses/gmp/ && \
	mkdir -p /tmp/dist/licenses/bfd && cp "/tmp/src/gdb-${GDB_VERSION}/bfd/COPYING" /tmp/dist/licenses/bfd/ && \
	mkdir -p /tmp/dist/licenses/libiberty && cp "/tmp/src/gdb-${GDB_VERSION}/libiberty/COPYING.LIB" /tmp/dist/licenses/libiberty/ && \
	mkdir -p /tmp/dist/licenses/zlib && cp "/tmp/src/gdb-${GDB_VERSION}/zlib/README" /tmp/dist/licenses/zlib/

# Retrieve the license files for GCC, since libgcc and libstdc++ are statically linked into the GDB executable
mkdir -p /tmp/dist/licenses/gcc && \
	curl -fSL 'https://raw.githubusercontent.com/gcc-mirror/gcc/master/COPYING3' -o /tmp/dist/licenses/gcc/COPYING3 && \
	curl -fSL 'https://raw.githubusercontent.com/gcc-mirror/gcc/master/COPYING.RUNTIME' -o /tmp/dist/licenses/gcc/COPYING.RUNTIME

# Create a README file with links to the locations of the source code for GDB and its dependencies
echo 'This directory contains a distribution of The GNU Project Debugger (GDB) in object form.' >> /tmp/dist/README.txt && \
	echo 'The binary was cross-compiled for various platforms, and are all statically linked against libgcc and libstdc++.' >> /tmp/dist/README.txt && \
	echo 'The licenses for GDB and its dependencies can be found in the `licenses` subdirectory.' >> /tmp/dist/README.txt && \
	echo '' >> /tmp/dist/README.txt && \
	echo 'The source code for GDB and its dependencies can be downloaded from the following URLs:' >> /tmp/dist/README.txt && \
	echo '' >> /tmp/dist/README.txt && \
	echo "- https://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.xz" >> /tmp/dist/README.txt && \
	echo "- https://gmplib.org/download/gmp/gmp-${GMP_VERSION}.tar.xz" >> /tmp/dist/README.txt && \
	echo '- https://github.com/gcc-mirror/gcc' >> /tmp/dist/README.txt && \
	echo '' >> /tmp/dist/README.txt

# Create a ZIP archive of the files for distribution
cd /tmp/dist && \
	zip -r "gdb-${GDB_VERSION}.zip" gdb* licenses/ README.txt

