.. ############################################################################
.. File  : doc/examples.rst
.. ############################################################################

********
Examples
********

The following standalone codes demonstrate how Flibcpp can be used in native
Fortran code.

String conversion and sort
==========================

This example:

 - Introspects the Flibcpp version;
 - Converts a user input to an integer, validating it with useful error
   messages;
 - Fills an array with normally-distributed real numbers; and
 - Sorts the array before printing the first few entries.

.. literalinclude:: ../example/sort.f90
   :linenos:

.. ############################################################################
.. end of doc/examples.rst
.. ############################################################################
