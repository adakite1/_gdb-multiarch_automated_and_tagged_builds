#!/usr/bin/env zsh

(
    # Set environment variables
    . vars.sh

    # Clear previous builds and get shared source files
    ./get.sh

    # Build
    ./build-mac-internal.sh

    # Finish up
    ./finish.sh
)
mv "/tmp/dist/gdb-${GDB_VERSION}.zip" ./gdb-${GDB_VERSION}-mac.zip

