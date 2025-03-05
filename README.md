Based upon https://github.com/adamrehn/gdb-multiarch-windows, this repository contains build scripts to cross-compile [The GNU Project Debugger (GDB)](https://www.sourceware.org/gdb/) for all major platforms.

## Building from source

To run the build scripts, you will need a system with a bash shell and a recent version of [Docker](https://www.docker.com/). To perform a build, simply run:

```bash
./build.sh
```


## Legal

The build scripts are licensed under the MIT License by all contributors. See the file [LICENSE](./LICENSE) for details.

Binary distributions created by the build scripts encapsulate GDB and its dependencies in object form, all statically linked into a single executable. See the `README.txt` file and `license` subdirectory included in each binary distribution ZIP archive for details on the licenses of these components and the locations from which their source code can be obtained.
