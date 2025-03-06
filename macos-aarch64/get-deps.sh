#!/usr/bin/env zsh

# Install shared build dependencies using Homebrew
brew install \
    autoconf \
    automake \
    curl \
    texinfo \
    flex \
    bison \
    libtool \
    pkg-config \
    wget \
    libmpc \
    isl \
    zstd \
    xz
brew reinstall --build-from-source zstd

# Note: build-essential, ca-certificates, and libc6-dev are not needed 
# as they're part of Xcode Command Line Tools

# tar and zip are already included in macOS base system