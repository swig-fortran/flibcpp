.. ############################################################################
.. File  : doc/modules/map.rst
.. ############################################################################

.. _modules_Map:

***
Map
***

Maps are sorted dictionaries mapping keys to values. Currently they have
limited functionality and few instantiations: maps of ints to ints and of
strings to strings.

Basic functionality
===================

All map types support the following basic operations.

Construction and destruction
----------------------------

Like other wrapped C++ classes in Flibcpp, maps are
constructed using an interface function. The default constructor is an empty
map.  Maps are destroyed using the ``release`` type-bound subroutine.

Modification
------------

The contents of the map can be changed with the following methods:

``insert``:
   Add a new key-value pair to the map. If the key already exists, the value in
   the map will remain unchanged. An optional ``logical`` parameter can be
   passed that will be set to ``.true.`` if insertion was successful and
   ``.false.`` if the key already existed.

``set``:
   Assign the given value to the key, regardless of whether the value already
   existed.

``get``:
   Return the value for the specified key, creating it with a default value
   (zero for numeric types, empty for string types) if it does not exist.

``clear``:
   Remove all items from the map.

The ``size`` method returns the number of elements, and ``count`` will return
the number of elements with the given key.

Here's an example of creating, modifying, and destroying a map::

  use flc_map, only : Map => MapIntInt
  type(Map) :: m
  logical :: inserted = .false.
  integer(C_INT) :: value
  m = Map()
  call m%insert(123, 456)
  call m%insert(123, 567, inserted) ! inserted = false, value unchanged
  call m%set(123, 567) ! value is changed
  value = m%get(911) ! implicitly created value of zero
  call m%erase(911)
  call m%release()

Iteration
---------

Iterating over a map to determine its contents is not yet supported.

.. ############################################################################
.. end of doc/modules/map.rst
.. ############################################################################
