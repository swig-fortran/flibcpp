.. ############################################################################
.. File  : doc/introduction.rst
.. ############################################################################

************
Introduction
************

The purpose of this library is to provide access to efficient and robust
algorithms and data types commonly used in scientific applications.

Installation
============

Flibcpp is built using modern CMake_, and it has no external dependencies. This
makes installation quite simple as long as you have a relatively recent
software stack with a Fortran and compatible C++ compiler.

1. Download and install CMake if it's not already on your system. It is highly
   recommended to use a package manager such as Homebrew_ for Mac or YUM_ for
   Red Hat Linux.
2. Download the `Flibcpp source code`_ from GitHub if you haven't already.
3. Create a new build directory (for example purposes, create a subdirectory
   named ``build`` inside your downloaded source directory) and ``cd`` to it.
4. Run CMake: ``cmake ..``
5. Make and install (by default it will install to ``/usr/local``):
   ``make install``.

By default, Flibcpp builds shared libraries. Add the CMake argument
``-DBUILD_SHARED_LIBS:BOOL=OFF`` to build static libraries.

.. _CMake: https://cmake.org
.. _Homebrew: https://brew.sh
.. _YUM: https://access.redhat.com/solutions/9934
.. _Flibcpp source code: https://github.com/swig-fortran/flibcpp/releases

Downstream usage
================

The Flibcpp library is most easily used when your downstream app is built with
CMake. It should require a single line to initialize::

   find_package(Flibcpp REQUIRED CONFIG)

and a single line to link against your app or library::

   target_link_libraries(example_backend Flibcpp::flc_random Flibcpp::flc_algorithm)

If your installation prefix for Flibcpp is a system default path (such as
``/usr/local``) or in your ``$CMAKE_PREFIX_PATH`` environment variable, it
should automatically find the necessary CMake configure file.

An `example Fortran application`_ that depends only on Flibcpp is
available on Github.

.. _example Fortran application: https://github.com/swig-fortran/flibcpp-example-app).

----

If you're using a simple standalone Makefile to build your Fortran code, you
will have to inform the compiler of the proper include path, library path, and
library names. Depending on your system configuration, you might have to
also explicitly link your app against the compiler's C++ standard libraries
using ``-lstdc++``.

Developing
==========

If you are interested in extending the capabilities of Flibcpp, you will need
the latest version of the `SWIG+Fortran`_ tool installed on your machine. When
configuring CMake, you will want to configure using
``cmake -DFLIBCPP_DEV=ON ..`` to enable tests and documentation. Tests,
examples, and documentation can be independently enabled using the
``FLIBCPP_BUILD_TESTS``, ``FLIBCPP_BUILD_EXAMPLES``, and ``FLIBCPP_BUILD_DOCS``
options.

.. _SWIG+Fortran: https://github.com/swig-fortran

.. ############################################################################
.. end of doc/introduction.rst
.. ############################################################################
