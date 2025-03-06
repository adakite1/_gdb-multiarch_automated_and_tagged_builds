#!/usr/bin/env zsh

# Make all scripts in the current directory executable
find .. -name "*.sh" -type f -exec chmod +x {} +

# Set environment variables
. ../vars.sh
# Determine the number of logical CPU cores the host system has
export CPU_CORES=$(sysctl -n hw.logicalcpu)

# Clear previous builds and get shared source files
./get-deps.sh
../get-src.sh
# Build
./build-mac-internal.sh
# Finish up
../finish.sh
mv "/tmp/dist/gdb-${GDB_VERSION}.zip" ./gdb-${GDB_VERSION}-mac.zip

