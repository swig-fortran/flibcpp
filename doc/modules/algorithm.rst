.. ############################################################################
.. File  : doc/modules/algorithm.rst
.. ############################################################################

.. _modules_algorithm:

*********
Algorithm
*********

Algorithms that take comparators (e.g. sort) will be instantiated with function
pointers that allow user functions to add arbitrary ordering by defining
``bind(C)`` functions and calling with ``c_funloc(my_comparator)``.

Wherever possible, array indices are returned as Fortran 1-offset native
integers, with the value 0 indicating off-the-end (e.g. "not found").

Sorting
=======


Searching
=========


Set operations
==============

Sorted arrays can be manipulated as "sets," supporting unions, intersections,
and differences.

Modifying
=========

.. _modules_algorithm_shuffle:

Shuffle
-------

The ``algorithm`` module depends on the ``random`` module so that it can use
the supported random number generator to randomly reorder an array.


.. ############################################################################
.. end of doc/modules/algorithm.rst
.. ############################################################################
