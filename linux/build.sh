#!/usr/bin/env bash

# Make all scripts in the current directory executable
find .. -name "*.sh" -type f -exec chmod +x {} +

# Set environment variables
. ../vars.sh
# Determine the number of logical CPU cores the host system has
export CPU_CORES=`lscpu -e=CORE | tail -n +2 | wc -l`

# LINUX
# Clear previous builds and get shared source files
./get-deps.sh
../get-src.sh
# Build
./build-linux-internal.sh
# Finish up
../finish.sh
mv "/tmp/dist/gdb-${GDB_VERSION}.zip" ./gdb-${GDB_VERSION}-linux.zip

# WINDOWS
# Clear previous builds and get shared source files
./get-deps.sh
../get-src.sh
# Build
./build-win-internal.sh
# Finish up
../finish.sh
mv "/tmp/dist/gdb-${GDB_VERSION}.zip" ./gdb-${GDB_VERSION}-mingw64.zip

