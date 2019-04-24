# Flibcpp

This project uses SWIG-Fortran to expose useful functionality from the C++
standard library to Fortran 2003 application developers. It generates
self-contained Fortran modules with native proxy classes and functions
which wrap the C++ standard library.

Currently it's designed around the C++11 standard library, and it instantiates
32- and 64-bit integers as well as double-precision floats.
All operations directly manipulate arrays of Fortran-owned data to minimize
overhead.

## Capabilities

Functionality includes:

- Sorting, both canonical and with custom comparison function
- Binary search for indices in a sorted array
- Pseudo-random number generation, including a Gaussian/normal distribution

## Getting started

Installation of Flibcpp is trivial, as it requires no external dependencies
other than existing and compatible C++ and Fortran compilers, and a relatively
recent version of CMake:

1. Clone the repository with `git clone https://github.com/swig-fortran/flibcpp` or [download a release](https://github.com/swig-fortran/flibcpp/releases)
2. Create a build directory and execute `cmake $PATH_TO_SOURCE` (requires CMake
   3.8 or higher)
3. Install using `make install`

More detailed installation instructions are available [in the
documentation](https://flibcpp.readthedocs.io/en/latest/introduction.html#installation).
An example Fortran application that depends only on Flibcpp is
available [on Github](https://github.com/swig-fortran/flibcpp-example-app).

## Documentation

The [latest documentation](https://flibcpp.readthedocs.io/en/latest) is hosted
on readthedocs.io.

## Contribute

Pull requests are welcome. Feature requests can be added as issues. If there is
strong interest in adding an option for C++03 compatibility, it could be
added. It would also be trivial to add support for single-precision
floats, but since most scientific software uses double-precision, we only
support those for now.

## License

The entirety of this repository and its generated code are released under an
MIT license. See the LICENSE file.

It must be linked against an existing C++ standard library implementation (e.g.
[libc++](https://libcxx.llvm.org) or [libstdc++](https://gcc.gnu.org/wiki/Libstdc++)), so those are not covered by this license.

SWIG is not required to use this project. SWIG-generated code does _not_
inherit SWIG's GPL license.
