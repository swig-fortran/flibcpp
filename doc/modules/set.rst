.. ############################################################################
.. File  : doc/modules/set.rst
.. ############################################################################

.. _modules_Set:

***
Set
***

Sets are sorted containers of unique elements. The ``flc_set`` module
defines sets of ``integer`` and of ``type(String)``.

Basic functionality
===================

All set types support the following basic operations.

Construction and destruction
----------------------------

Like other wrapped C++ classes in Flibcpp, sets are
constructed using an interface function. The default constructor is an empty
set.  Sets are destroyed using the ``release`` type-bound subroutine.

Modification
------------

The two primary operations on a set are ``insert`` and ``erase`` for adding
an element to and removing an element from the set. A ``clear`` subroutine
removes all elements from the set.

The ``size`` method returns the number of elements, and ``count`` will return
the number of elements of a given value.

Here's an example of creating, modifying, and destroying a set::

   use flc_set, only : Set => SetInt
   type(Set) :: s
   logical :: inserted
   s = Set()
   call s%insert(2)
   call s%insert(3, inserted) ! Set has 2 elements, inserted => true
   call s%insert(3, inserted) ! Duplicate element, ignored; inserted => false
   call s%erase(2) ! Remove 2 from the set
   call s%erase(1) ! Nonexistent set element, ignored
   write(0,*) "Number of 3s in the set:" s%count(3)
   call s%clear() ! Remove all elements, size is now zero
   call s%insert(1)
   call s%release() ! Free memory

Set operations
--------------

The Fortran ``Set`` classes have been extended to include several useful set
algorithms. (In C++, these are implemented using the ``<algorithm>`` header and
therefore should resemble the functions in
:ref:`the flc_algorithm module <modules_algorithm_set_operations>`.

All set operations take a single argument, another ``Set`` object, and do not
modify either the original or the argument. All but the ``includes`` return
newly allocated ``Set`` instances and do not modify the original sets.

``difference``: :math:`A \setminus B`
   Returns a new set with all elements from the original that are *not* present
   in the other set.

``intersection``: :math:`A \cap B`
  Return all elements that are in both sets.

``symmetric_difference``: :math:`(A \setminus B) \cup (B \setminus A)`
  Return all elements that are in one set or the other but not both.

``union``: :math:`A \cup B`
  Return all elements that are in either set.

``includes``: :math:`A \supseteq B`
  Return whether all elements of the other set are in the original set.

Iteration
---------

Iterating over a set to determine its contents is not yet supported.

Numeric sets
===============

Unlike :ref:`vectors<modules_Vector>`, the ``flc_set`` module includes
a single "native integer" numeric instantiations. The value type is
``integer(C_INT)`` and is 64 bits on most modern systems. Since the C++
implementation of numerical sets is not very efficient, the assumption is that
the ``set`` will be used in a non-numerically-intensive capacity where the
default integer is the most appropriate option.

Construct from an array
-----------------------

Numeric sets can be created very efficiently from Fortran data by accepting
an array argument::

   use flc_set, only : Set => SetInt
   type(Set) :: s

   s = Set([1, 1, 2, 10])
   write(0,*) "Size should be 3:", s%size()

The ``assign`` bound method acts like a constructor but for an existing set.

String sets
==============

The native "element" type of ``SetString`` is a ``character(len=:)``. Set
operations that accept an input will take any native character string; and
returned values will be allocatable character arrays.

An additional ``insert_ref`` function allows assignment of
:ref:`String types <modules_string_type>`

.. ############################################################################
.. end of doc/modules/set.rst
.. ############################################################################
