#!/usr/bin/env bash

# Install build tools
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    clang \
	lld \
	lldb

