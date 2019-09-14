.. ############################################################################
.. File  : doc/modules/vector.rst
.. ############################################################################

.. _modules_Vector:

******
Vector
******

Vectors are resizeable arrays of elements. The ``flc_vector`` module
instantiates vectors of ``integer(4)``,  ``integer(8)``,  ``real(8)``, and
``type(String)``.

Common functionality
====================

All vector types support the following basic operations.

Construction and destruction
----------------------------

Vectors are constructed using three interface functions:

  - The function without arguments creates an empty vector;
  - A single integer argument assigns that many elements with default values;
    and
  - An integer argument followed by an element with the vector's element type
    will copy that value to all elements of the vector.

(To do: copy construction)

Here are three examples of initialization::

   use flc_vector, only : Vector => VectorInt4
   type(Vector) :: v

   v = Vector()
   ! v%size() == 0
   v = Vector(10)
   ! v%size() == 10
   ! v%get(i) == 0
   v = Vector(10, 123)
   ! v%size() == 10
   ! v%get(i) == 123

Vectors are destroyed using the ``release`` type-bound subroutine::

   call v%release()

Modification
------------

Vectors can be resized dynamically using ``resize``, which acts like the
constructors described above. An element can be added to
the end of the vector (increasing the size by one) with ``push_back``. The
``insert`` method can insert an element at a specific index, and ``erase``
removes a specific vector index or range of indices. ``clear`` removes
all elements. Finally, ``set`` sets the value of an element at a given index.

.. important:: Unlike the C++ version of this class, **all vectors in Flibcpp
   use 1-offset indexing**. This means that ``v%get(1)`` is the same as the C++
   ``v[0]``: it returns the first element (i.e. the element with an offset of
   zero).

Here's an example of modifying a vector::

   use flc_vector, only : Vector => VectorInt4
   type(Vector) :: v
   v = Vector()
   call v%resize(4, 123) ! give each element the value 123
   call v%push_back(-1) ! size increased by 1, last element has value -1
   call v%insert(2, -2) ! First 3 elements are [123, 123, -2]
   call v%erase(1, 3) ! Remove the first two elements
   call v%erase(2) ! Remove the second element
   call v%set(1, -123) ! Change the value of the first element
   call v%clear() ! Remove all elements, size is now zero

Access
------

The size of a vector is returned by the bound function ``size``; ``get``
returns the value at an index; and ``front`` and ``back`` are aliases for
``get(1)`` and ``get(v%size())``, respectively.

Additionally, ``front_ref``, ``back_ref``, and ``get_ref`` return pointers to
the elements of the array.

.. warning:: Array element pointers are valid **only** as long as the vector's
  size is not changed. Calling ``erase``, ``push_back``, and so forth will
  invalidate the pointer; accessing it at that point results in undefined
  behavior.

Numeric vectors
===============

As with the algorithms and other methods, the ``flc_vector`` module includes
three numeric instantiations. They each have distinct derived types:

 - ``VectorInt4``: each element is ``integer(4)``
 - ``VectorInt8``: each element is ``integer(8)``
 - ``VectorReal8``: each element is ``real(8)``

Construct from an array
-----------------------

Numeric vectors can be created very efficiently from Fortran data by accepting
an array pointer::

   use flc_vector, only : Vector => VectorInt4
   integer(4), dimension(4), parameter :: iarr = [ 1, -2, 4, -8 ]
   type(Vector) :: v

   v = Vector(iarr)
   write(0,*) "Size should be 4:", v%size()

The ``assign`` bound method acts like a constructor but for an existing vector.

View as an array pointer
------------------------

Numeric vectors can also return an array pointer to the vector's contents.
These views support native Fortran array operations and access the same
underlying memory as the C++ object::

   use flc_vector, only : Vector => VectorInt4
   integer(4), dimension(:), pointer :: vptr
   type(Vector) :: v

   ! <snip>
   vptr => v%view()
   if (size(vptr) > 2) then
      vptr(2) = 4
   end if

.. warning:: A vector's view is valid **only** as long as the vector's size is
  not changed. Calling ``erase``, ``push_back``, and so forth will invalidate
  the view; accessing it at that point results in undefined behavior.

String vectors
==============

The native "element" type of ``VectorString`` is a ``character(len=:)``. Vector
operations that accept an input will take any native character string; and
returned values will be allocatable character arrays.

The ``front_ref``, ``back_ref``, and ``get_ref`` functions allow the underlying
``std::string`` class to be accessed with the ``String`` Fortran derived type
wrapper. Note that unlike for intrinsic types, where these functions return a
``integer, pointer``, the vector of strings returns just ``type(String)``.
However, as with native pointers described above, these references are
*invalid* once the string changes size. They should be cleared with the
``%release()`` bound method.

An additional ``set_ref`` function allows vector elements to be assigned from
vector classes.

.. ############################################################################
.. end of doc/modules/vector.rst
.. ############################################################################
