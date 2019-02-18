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

Algorithms that take comparators (e.g. sorting and searching) are instantiated
with function pointers that allow user functions to add arbitrary ordering by
defining ``bind(C)`` functions and calling with ``c_funloc(my_comparator)``.

Wherever possible, array indices are returned as Fortran 1-offset native
integers, with the value 0 indicating off-the-end (e.g. "not found").

.. _<algorithm> : https://en.cppreference.com/w/cpp/numeric/random

Sorting
=======

sort
----

Sorting and checking order is a single simple subroutine call::

  use flc_algorithm, only : sort
  implicit none
  integer, dimension(5) :: iarr = [ 2, 5, -2, 3, -10000]

  call sort(iarr)

is_sorted
---------

Checking the ordering of array is just as simple::

  use flc_algorithm, only : is_sorted
  integer, dimension(5) :: iarr = [ 2, 5, -2, 3, -10000]
  logical :: sortitude

  sortitude = is_sorted(iarr)

argsort
-------

A routine that provides the indices that correspond to a sorted array, like
Numpy's argsort_ ,
takes an array to analyze and an empty array of integers to fill::

  use flc_algorithm, only : argsort
  implicit none
  integer, dimension(5) :: iarr = [ 2, 5, -2, 3, -10000]
  integer(C_INT), dimension(5) :: idx

  call argsort(iarr, idx)
  ! This line prints a sorted array:
  write(*,*) iarr(idx)

Note that the index array is always a ``C_INT``. On some compilers and
platforms, this may be the same as native Fortran integer, but it's not
guaranteed.

The ``data`` and ``idx`` arguments to ``argsort`` *must* be the same size. If
the index array is larger than the data, invalid entries will be filled with
zero.

.. _argsort: https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.argsort.html

Searching
=========

binary_search
-------------

A binary search can be performed on sorted data to efficiently find an element
in a range. If the element is not found, the function returns zero; otherwise,
it returns the Fortran index of the array.

The input array **must** be sorted.

Example::

  use flc_algorithm, only : binary_search
  implicit none
  integer :: idx
  integer, dimension(6) :: iarr = [ -5, 1, 1, 2, 4, 9]

  idx = binary_search(iarr, -100) ! returns 0
  idx = binary_search(iarr, 1)    ! returns 2
  idx = binary_search(iarr, 2)    ! returns 4
  idx = binary_search(iarr, 3)    ! returns 0
  idx = binary_search(iarr, 9)    ! returns 6
  idx = binary_search(iarr, 10)   ! returns 0

minmax_element
--------------

TODO

Set operations
==============

Sorted arrays can be manipulated as "sets," supporting unions, intersections,
and differences. TODO.

includes
--------

TODO

set_difference
--------------

TODO

set_intersection
----------------

TODO

set_symmetric_difference
------------------------

TODO

set_union
---------

TODO

Modifying
=========

.. _modules_algorithm_shuffle:

shuffle
-------

The "shuffle" subroutine depends on the :ref:`modules_random` module so that it
can use the supported random number generator to randomly reorder an array.

unique
------

TODO

.. ############################################################################
.. end of doc/modules/algorithm.rst
.. ############################################################################
