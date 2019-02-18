/*!
 * \file flc_random.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_random"
%import "flc.i"
%flc_add_header

/******************************
 * Generator definition
 ******************************/

%{
#include <random>
%}

// TODO: define a CMake-configurable option for selecting the 32-bit twister
#if 0
#define SWIG_MERSENNE_TWISTER mt19937
#define SWIG_MERSENNE_RESULT_TYPE int32_t
#else
#define SWIG_MERSENNE_TWISTER mt19937_64
#define SWIG_MERSENNE_RESULT_TYPE int64_t
#endif

%rename(Engine) std::SWIG_MERSENNE_TWISTER;

namespace std {
class SWIG_MERSENNE_TWISTER
{
  public:
    typedef SWIG_MERSENNE_RESULT_TYPE result_type;

    SWIG_MERSENNE_TWISTER();
    explicit SWIG_MERSENNE_TWISTER(result_type);
    void seed(result_type);
    void discard(unsigned long long);
};
} // namespace std

/******************************
 * Distributions
 *
 * The generated subroutines will be called from Fortran like:
 *
 *     call uniform_real_distribution(gen, -10, 10, fill_array)
 ******************************/

%define %flc_random_distribution1(DISTNAME, TYPE, ARG1)
%inline {
static void DISTNAME(TYPE ARG1,
                     std::SWIG_MERSENNE_TWISTER& g,
                     TYPE *DATA, size_t DATASIZE) {
    std::DISTNAME<TYPE> dist(ARG1);
    TYPE *end = DATA + DATASIZE;
    while (DATA != end) {
        *DATA++ = dist(g);
    }
}
}
%enddef
%define %flc_random_distribution2(DISTNAME, TYPE, ARG1, ARG2)
%inline {
static void DISTNAME(TYPE ARG1, TYPE ARG2,
                     std::SWIG_MERSENNE_TWISTER& g,
                     TYPE *DATA, size_t DATASIZE) {
    std::DISTNAME<TYPE> dist(ARG1, ARG2);
    TYPE *end = DATA + DATASIZE;
    while (DATA != end) {
        *DATA++ = dist(g);
    }
}
}
%enddef

// Uniform distributions
%flc_random_distribution2(uniform_int_distribution, int32_t, left, right)
%flc_random_distribution2(uniform_int_distribution, int64_t, left, right)
%flc_random_distribution2(uniform_real_distribution, double, left, right)

// Gaussian distribution
%flc_random_distribution1(normal_distribution, double, mean)
%flc_random_distribution2(normal_distribution, double, mean, stddev)
