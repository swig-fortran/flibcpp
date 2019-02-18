.. ############################################################################
.. File  : doc/modules/algorithm.rst
.. ############################################################################

.. _modules_algorithm:

*********
Algorithm
*********

The ``flc_algorithm`` module wraps C++ standard `<algorithm>`_ routines.
Instead of taking pairs of iterators, the Flibcpp algorithm subroutines accept
target-qualified 1-D arrays.

Algorithms that take comparators (e.g. sort) will be instantiated with function
pointers that allow user functions to add arbitrary ordering by defining
``bind(C)`` functions and calling with ``c_funloc(my_comparator)``.

Wherever possible, array indices are returned as Fortran 1-offset native
integers, with the value 0 indicating off-the-end (e.g. "not found").

.. _<algorithm> : https://en.cppreference.com/w/cpp/numeric/random

Sorting
=======

Sorting and checking order is a single simple subroutine call::

  use flc_algorithm, only : sort, is_sorted
  implicit none
  integer, dimension(5) :: iarr = [ 2, 5, -2, 3, -10000]
  logical :: result

  call sort(iarr)
  result = is_sorted(iarr)

Searching
=========

A binary search can be performed on sorted data to efficiently find an element
in a range. If the element is not found, the function returns zero; otherwise,
it returns the Fortran index of the array.

The input array **must** be sorted.

Example::

  use flc_algorithm, only : binary_search
  implicit none
  integer :: index
  integer, dimension(6) :: iarr = [ -5, 1, 1, 2, 4, 9]

  index = binary_search(iarr, -100) ! returns 0
  index = binary_search(iarr, 1)    ! returns 2
  index = binary_search(iarr, 2)    ! returns 4
  index = binary_search(iarr, 3)    ! returns 0
  index = binary_search(iarr, 9)    ! returns 6
  index = binary_search(iarr, 10)   ! returns 0


Set operations
==============

Sorted arrays can be manipulated as "sets," supporting unions, intersections,
and differences. TODO.

Modifying
=========

.. _modules_algorithm_shuffle:

Shuffle
-------

The ``algorithm`` module depends on the ``random`` module so that it can use
the supported random number generator to randomly reorder an array.

Unique
------

TODO

.. ############################################################################
.. end of doc/modules/algorithm.rst
.. ############################################################################
