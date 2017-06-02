# diffutils-mingw-static
MSYS2 script to compile statically-linked GNU diffutils with the MinGW64 toolchain.

From a MinGW32/64 MSYS2 console, simply run `./build.sh`

You might need to install some packages:

```sh
pacboy -S toolchain:m
pacboy -S gettext:m
```

Stripped binaries will be the `/out/<architecture>` directory, along with a copy of the GPL3 and a file with a link to this repository, and the commit checked out when building.