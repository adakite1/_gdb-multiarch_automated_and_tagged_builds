This repository contains build scripts to cross-compile [The GNU Project Debugger (GDB)](https://www.sourceware.org/gdb/) for all major platforms.

Each folder corresponds to a host upon which the build scripts within should be run. The following hosts are thus supported:
- `linux`
- `macos-aarch64`
- `macos-amd64`

To build, simply `cd` into one of those folders, and then run the `build.sh` script within. At the end, in the same working directory, you should see a zip file named `gdb-16.2-<target name>.zip` which contains the `gdb` binary itself, `gdbserver` on supported targets (linux and windows targets), as well as a `README.txt` file and all `licenses` pertaining to the object file.

## Legal

The build scripts are licensed under the MIT License by all contributors. It was originally a fork of https://github.com/adamrehn/gdb-multiarch-windows. See the file [LICENSE](./LICENSE) for details.

Binary distributions created by the build scripts encapsulate GDB and its dependencies in object form, all statically linked into a single executable. See the `README.txt` file and `license` subdirectory included in each binary distribution ZIP archive for details on the licenses of these components and the locations from which their source code can be obtained.
