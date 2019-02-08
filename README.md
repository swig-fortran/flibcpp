# flibcpp

This project uses SWIG-Fortran to expose useful functionality from the C++
standard library to Fortran 2003 application developers. It generates
self-contained Fortran modules with native proxy classes and functions
which wrap the C++ library.

Currently it's designed around the C++11 standard library, and it instantiates
32- and 64-bit integers as well as double-precision floats.

## Getting started

TODO

## Documentation

TODO (to be published on github pages)

## Contribute

Pull requests are welcome. Feature requests can be added as issues. If there is
strong interest in adding an option for C++03 compatibility, it could be
eventually added. It would also be trivial to add support for single-precision
floats, but since most scientific software uses double-precision, we only
support those for now.

## License

The entirety of this repository and its generated code are released under an
MIT license. See the LICENSE file.

It must be linked against an existing C++ standard library implementation (e.g.
[libc++](https://libcxx.llvm.org) or [libstdc++](https://gcc.gnu.org/wiki/Libstdc++)), so those are not covered by this license.

SWIG is not required to use this project. SWIG-generated code does _not_
inherit SWIG's GPL license.
