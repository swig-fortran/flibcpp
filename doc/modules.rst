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

   use flc_algorithm, only : sort

All templated routines are instantiated with 32- and 64-bit signed integers
(``integer(4)`` and ``integer(8)``), and double-precision floats (``real(8)``).

Some modules support error handling for checking input values. In all cases,
the error status and a message can be accessed and cleared through the main
``flc`` module::

   use flc, only : ierr, get_serr

   ! <snip>
   if (ierr /= 0) then
     write(1,*) "Error", ierr, ":", get_serr()
     ! Reset the error flag to indicate that the error has been successfully
     ! handled.
     ierr = 0
   fi

.. toctree::
   modules/algorithm.rst
   modules/chrono.rst
   modules/map.rst
   modules/random.rst
   modules/set.rst
   modules/string.rst
   modules/vector.rst


.. ############################################################################
.. end of doc/modules.rst
.. ############################################################################
