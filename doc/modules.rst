.. ############################################################################
.. File  : doc/modules.rst
.. ############################################################################

*******
Modules
*******

Flibcpp is organized into distinct modules whose structure mirrors the C++
standard library include headers.

The modules themselves are namespaced with a ``flc_`` prefix, so
for example the ``std::sort`` algorithm, available in the ``<algorithm>``
header, can be obtained via::

   use :: flc_algorithm, only : sort

All templated routines are instantiated with 32- and 64-bit signed integers,
and double-precision floats.

.. toctree::
   modules/algorithm.rst
   modules/chrono.rst
   modules/map.rst
   modules/random.rst
   modules/set.rst
   modules/string.rst


.. ############################################################################
.. end of doc/modules.rst
.. ############################################################################
