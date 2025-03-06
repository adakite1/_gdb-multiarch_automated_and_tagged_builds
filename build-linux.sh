#!/usr/bin/env bash

# LINUX

# Set environment variables
. vars.sh

# Clear previous builds and get shared source files
./get-deps.sh
./get-src.sh

# Build
./build-linux-internal.sh

# Finish up
./finish.sh

mv "/tmp/dist/gdb-${GDB_VERSION}.zip" ./gdb-${GDB_VERSION}-linux.zip

# WINDOWS

# Set environment variables
. vars.sh

# Clear previous builds and get shared source files
./get-deps.sh
./get-src.sh

# Build
./build-win-internal.sh

# Finish up
./finish.sh

mv "/tmp/dist/gdb-${GDB_VERSION}.zip" ./gdb-${GDB_VERSION}-mingw64.zip

