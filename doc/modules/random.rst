.. ############################################################################
.. File  : doc/modules/random.rst
.. ############################################################################

.. _modules_random:

******
Random
******

The ``flc_random`` module contains advanced pseudo-random number generation
from the `<random>`_ C++ header.

The C++11 way of generating random numbers takes some getting used to. Rather
than having a single global function that returns a random real number in the
range :math:`[0,1)`, C++11 has independent *engine* objects that generate
streams of random bits. Different *distribution* objects convert those bits
into samples of a distribution.

Although C++11 defines a dizzying variety of random number engines,
``flc_random`` wraps just two: the 32- and 64-bit `Mersenne Twister`
algorithms. The 32-bit version (``MersenneEngine4``) is currently the only
engine type that can be used with distributions and algorithms.

Flibcpp wraps distribution objects as independent subroutines. Each subroutine
accepts the constructor parameters of the distribution, the random engine, and
a target Fortran array to be filled with random numbers.

Generating an array with 10 normally-distributed reals with a mean of 8 and a
standard deviation of 2 is done as such::

    use flc_random, only : Engine => MersenneEngine4, normal_distribution
    real(C_DOUBLE), dimension(20) :: arr
    type(Engine) :: rng

    rng = Engine()
    call normal_distribution(8.0d0, 2.0d0, rng, arr)
    call rng%release()

.. _<random> : https://en.cppreference.com/w/cpp/numeric/random
.. _Mersenne Twister : https://en.wikipedia.org/wiki/Mersenne_Twister

Engines
=======

The two Mersenne twister engines in ``flc_random`` return different-sized
integers per call:

 - ``MersenneEngine4``: each invocation returns a 32-bit ``integer(4)``
 - ``MersenneEngine8``: each invocation returns a 64-bit ``integer(8)``

Engines can be constructed using one of two interface functions: the
argument-free ``MersenneEngine4()`` uses the default seed, and the engine takes
a single argument ``MersenneEngine4(1234567)`` with the seed. Alternatively,
the seed can be set (or reset) using the ``seed()`` type-bound procedure.

Generally, engines are used with distributions (described below). However, if
necessary, individual randomly generated values can be obtained by calling
the ``next()`` type-bound procedure.

.. warning:: C++ generates *unsigned* integers with entropy in every bit. This
   means that the integers obtained from ``engine%next()``, reinterpreted as
   signed Fortran integers, may be negative.

In most cases, the default distribution-compatible ``MersenneEngine4`` should
be used, since the distributions described below require it.

Distributions
=============

Distributions produce numerical values from the random bitstream provided by
an RNG engine.

normal_distribution
-------------------

Fill the given array with Gaussian-distributed numbers generated using the
given random number engine about the given mean value with the given standard
deviation, which defaults to 1.

uniform_int_distribution
------------------------

Fill the given array with uniformly distributed integers generated using the
given random number engine, between the two bounds (inclusive on both sides).

uniform_real_distribution
-------------------------

Fill the given array with uniformly distributed real numbers generated using the
given random number engine, between the two bounds (inclusive on left side only).


.. ############################################################################
.. end of doc/modules/random.rst
.. ############################################################################
