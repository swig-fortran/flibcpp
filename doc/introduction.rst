.. ############################################################################
.. File  : doc/introduction.rst
.. ############################################################################

************
Introduction
************

The Fortran programming language includes many mathematical functions but few
of the generic, high-performance software algorithms and data containers needed
by essentially all modern scientific software. Most Fortran software contains
hand-written code for such algorithms that may be burdensome to maintain and
inflexible, as well as unperformant and erroneous under certain conditions.

Flibcpp  [#flibcpp_vers]_ is a library for use by application developers that provides native
Fortran interfaces to existing high-quality algorithms and containers
implemented in C++ and available on all modern computer systems.

Flibcpp defines a carefully crafted set of interface files written for the
SWIG-Fortran code generator :cite:`johnson_automated_2020`, an extension of
SWIG :cite:`beazley_automated_2003`. These Fortran interfaces generate native
Fortran
proxy code that comprises a set of thin wrappers to selected functionality in
the C++ standard library. The resulting code is a set of Fortran modules and
C++ wrappers that expose a concise and well-defined interface that may be built
into and distributed with the application.

The generated modules include functionality for efficient generic sorting and
searching, set operations, random number generation, value mapping, string
manipulation, and dynamically resizing vectors.

.. [#flibcpp_vers] This documentation is generated from Flibcpp |release|.

.. ############################################################################
.. end of doc/introduction.rst
.. ############################################################################
