#!/usr/bin/env bash

# Install shared build dependencies
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    ca-certificates \
    curl \
    tar \
    zip \
    texinfo \
    flex \
    bison \
    libiconv-hook-dev \
    libc6-dev