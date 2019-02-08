.. ############################################################################
.. File  : doc/modules/random.rst
.. ############################################################################

.. _modules_random:

******
Random
******

Advanced pseudo-random number generation from the `<random>`_ header. Currently
random number generation is hardwired to the ``std::mt19937_64`` 64-bit
Mersenne Twister by Matsumoto and Nishimura.

The C++11 way of generating random numbers takes some getting used to. Rather
than having a single global function that returns a random real number in the
range :math:`[0,1)`, C++11 has independent *engine* objects that generate
streams of random bits. Different *distribution* objects convert those bits
into samples of a distribution.

Flibcpp wraps distribution objects as independent subroutines. Each subroutine
accepts the constructor parameters of the distribution, the random engine, and
a target Fortran array to be filled with random numbers.

Generating an array with 10 normally-distributed reals with a mean of 8 and a
standard deviation of 2 is done as such::

    use flc_random, only : Engine, normal_distribution
    real(C_DOUBLE), dimension(20) :: arr
    type(Engine) :: rng

    rng = Engine()
    call normal_distribution(8.0d0, 2.0d0, rng, arr)

Engine
======

The ``Engine`` is a derived type that wraps the Mersenne Twister PRNG engine.
Its interface is::

    type, public :: Engine
    contains
     procedure :: seed => swigf_Engine_seed
     procedure :: discard => swigf_Engine_discard
     procedure :: release => delete_Engine
    end type Engine
    interface Engine
     module procedure new_Engine
    end interface

Normal distribution
===================

Uniform integer distribution
============================

Uniform real distribution
=========================




.. _<random> : https://en.cppreference.com/w/cpp/numeric/random

.. ############################################################################
.. end of doc/modules/random.rst
.. ############################################################################
