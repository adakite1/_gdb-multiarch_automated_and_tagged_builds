# Clean previous builds and remake the build folder
rm -rf /tmp/build /tmp/dist /tmp/install
mkdir /tmp/src

# Download and extract the source code for libGMP
if [ ! -f "/tmp/gmp-${GMP_VERSION}.tar.xz" ]; then
    curl -fSL "https://ftp.gnu.org/gnu/gmp/gmp-${GMP_VERSION}.tar.xz" -o "/tmp/gmp-${GMP_VERSION}.tar.xz"
fi
tar xvf "/tmp/gmp-${GMP_VERSION}.tar.xz" --directory /tmp/src

# Download and extract the soruce code for libMPFR
if [ ! -f "/tmp/mpfr-${MPFR_VERSION}.tar.xz" ]; then
    curl -fSL "https://ftp.gnu.org/gnu/mpfr/mpfr-${MPFR_VERSION}.tar.xz" -o "/tmp/mpfr-${MPFR_VERSION}.tar.xz"
fi
tar xvf "/tmp/mpfr-${MPFR_VERSION}.tar.xz" --directory /tmp/src

# Download and extract the source code for libexpat
if [ ! -f "/tmp/expat-${EXPAT_VERSION}.tar.xz" ]; then
    curl -fSL "https://github.com/libexpat/libexpat/releases/latest/download/expat-${EXPAT_VERSION}.tar.xz" -o "/tmp/expat-${EXPAT_VERSION}.tar.xz"
fi
tar xvf "/tmp/expat-${EXPAT_VERSION}.tar.xz" --directory /tmp/src

# Download and extract the source code for GDB
if [ ! -f "/tmp/gdb-${GDB_VERSION}.tar.xz" ]; then
    curl -fSL "https://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.xz" -o "/tmp/gdb-${GDB_VERSION}.tar.xz"
fi
tar xvf "/tmp/gdb-${GDB_VERSION}.tar.xz" --directory /tmp/src

