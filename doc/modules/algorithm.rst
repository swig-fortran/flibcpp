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
defining ``bind(C)`` functions.

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

  use flc_algorithm, only : argsort, INDEX_INT
  implicit none
  integer, dimension(5) :: iarr = [ 2, 5, -2, 3, -10000]
  integer(INDEX_INT), dimension(5) :: idx

  call argsort(iarr, idx)
  ! This line prints a sorted array:
  write(*,*) iarr(idx)

Note that the index array is always a ``INDEX_INT``, which is an alias to
``C_INT``. On some compilers and platforms, this may be the same as native
Fortran integer, but it's not guaranteed.

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

  use flc_algorithm, only : binary_search, INDEX_INT
  implicit none
  integer(INDEX_INT) :: idx
  integer, dimension(6) :: iarr = [ -5, 1, 1, 2, 4, 9]

  idx = binary_search(iarr, -100) ! returns 0
  idx = binary_search(iarr, 1)    ! returns 2
  idx = binary_search(iarr, 2)    ! returns 4
  idx = binary_search(iarr, 3)    ! returns 0
  idx = binary_search(iarr, 9)    ! returns 6
  idx = binary_search(iarr, 10)   ! returns 0

equal_range
-----------

Finds the range of elements in a sorted array equivalent to the given value. If
the exact value isn't present, the first index will point
to the index at which the value could be inserted to maintain a sorted array.
If searching for a value that's in the sorted array more than once, the
expression ``arr(first_idx:last_idx)`` will return the equal values. If the
value isn't present, ``arr(first_idx:last_idx)`` will be an empty array, and
the first index will be the point at which the element would be located if it
were present.

Example::

  use flc_algorithm, only : equal_range, INDEX_INT
  implicit none
  integer(INDEX_INT) :: first, last
  integer, dimension(6) :: iarr = [ -5, 1, 1, 2, 4, 9]

  call equal_range(iarr, -6, first, last) ! (first,last) are (1,0)
  call equal_range(iarr, -5, first, last) ! (first,last) are (1,1)
  call equal_range(iarr,  1, first, last) ! (first,last) are (2,3)
  call equal_range(iarr,  3, first, last) ! (first,last) are (5,4)
  call equal_range(iarr,  9, first, last) ! (first,last) are (6,6)


minmax_element
--------------

Finds the smallest and largest element in an array.
Note that the *first* occurrence of the minimum value is selected, and the
*last* occurrence of the maximum value is selected. Thus, for a sorted array
``arr`` which may have duplicate elements, the expression
``arr(min_idx:max_idx)`` will always return the entire array.

Example::

  use flc_algorithm, only : minmax_element, INDEX_INT
  implicit none
  integer, dimension(6) :: iarr = [ -5, 1000, -1000, 999, -1000, 1000]
  integer(INDEX_INT) :: min_idx, max_idx

  call minmax_element(iarr, min_idx, max_idx) ! min_idx == 3, max_idx == 6

Set operations
==============

Sorted arrays can be manipulated as "sets," supporting unions, intersections,
and differences.

includes
--------

Whether one set encloses another set: every item of the second array is present
in the first array.

Example::

  use flc_algorithm, only : includes
  implicit none
  integer, dimension(6) :: iarr = [ -5, 1, 2, 4, 9]
  integer, dimension(3) :: jarr = [ 1, 2, 5]
  logical :: is_superset

  is_superset = includes(iarr, iarr)) ! true
  is_superset = includes(iarr, iarr(:3))) ! true
  is_superset = includes(iarr, iarr(3:))) ! true
  is_superset = includes(iarr(3:), iarr)) ! false
  is_superset = includes(iarr, jarr) ! false
  is_superset = includes(iarr, jarr(1:2))) ! true

Not yet implemented
-------------------

- set_difference
- set_intersection
- set_symmetric_difference
- set_union

Modifying
=========

.. _modules_algorithm_shuffle:

shuffle
-------

The "shuffle" subroutine depends on the :ref:`modules_random` module so that it
can use the supported random number generator to randomly reorder an array.

Example::

  use flc_algorithm, only : shuffle
  use flc_random, only : Engine
  implicit none
  integer :: i
  integer, dimension(8) :: iarr = (/ ((i), i = -4, 3) /)
  type(Engine) :: rng
  rng = Engine()

  call shuffle(rng, iarr)

Not yet implemented
-------------------

- unique


.. ############################################################################
.. end of doc/modules/algorithm.rst
.. ############################################################################
