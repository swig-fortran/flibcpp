.. ############################################################################
.. File  : doc/examples.rst
.. ############################################################################

********
Examples
********

The following standalone codes demonstrate how Flibcpp can be used in native
Fortran code.

Random numbers and sorting
==========================

This simple example generates an array of normally-distributed double-precision
reals, sorts them, and then shuffles them again.

.. literalinclude:: ../example/sort.f90
   :linenos:

Vectors of strings
==================

Strings and vectors of strings can be easily manipulated and converted to and
from native Fortran strings.

.. literalinclude:: ../example/vecstr.f90
   :linenos:

.. _example_generic:

Generic sorting
===============

Since sorting algorithms often allow :math:`O(N)` algorithms to be written in
:math:`O(\log N)`, providing generic sorting routines is immensely useful in
applications that operate on large chunks of data. This example demonstrates
the generic version of the :ref:`modules_algorithm_argsort` subroutine by
sorting a native Fortran array of native Fortran types using a native Fortran
subroutine. The only C interaction needed is to create C pointers to the
Fortran array entries and to provide a C-bound comparator that
converts those pointers back to native Fortran pointers. [#c_f_pointer]_

.. literalinclude:: ../example/sort_generic.f90
   :linenos:

.. _example_utils:

Example utilities module
========================

This pure-Fortran module builds on top of functionality from Flibcpp. It
provides procedures to:

 - Format and print the Flibcpp version;
 - Converts a user input to an integer, validating it with useful error
   messages;
 - Reads a dynamically sized vector of strings from the user.

.. literalinclude:: ../example/example_utils.f90
   :linenos:


.. rubric:: Footnotes

.. [#c_f_pointer] Older versions of Gfortran (before GCC-8) fail to compile the
   generic sort example because of a bug that incorrectly claims that taking
   the C pointer of a scalar Fortran value is a violation of the standard:

   .. code-block:: none

      ../example/sort_generic.f90:84:38:

           call c_f_pointer(cptr=rcptr, fptr=rptr)
                                            1
      Error: TS 29113/TS 18508: Noninteroperable array FPTR at (1) to
      C_F_POINTER: Expression is a noninteroperable derived type

   See `this bug report`_ for more details.

   .. _this bug report: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84924


.. ############################################################################
.. end of doc/examples.rst
.. ############################################################################
