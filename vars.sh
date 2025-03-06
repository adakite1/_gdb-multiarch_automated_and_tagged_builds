#!/usr/bin/env bash

# The versions of GDB and libGMP that we will build
export GDB_VERSION='16.2'
export GMP_VERSION='6.3.0'
export MPFR_VERSION='4.2.1'

# Determine the number of logical CPU cores the host system has
export CPU_CORES=`lscpu -e=CORE | tail -n +2 | wc -l`

