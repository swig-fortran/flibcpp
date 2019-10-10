/*!
 * \file flc_random.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_random"
%include "import_flc.i"
%flc_add_header

%{
#include <random>
%}

/* -------------------------------------------------------------------------
 * Macros
 * ------------------------------------------------------------------------- */

%define %flc_random_engine(NAME, GENERATOR, RESULT_TYPE)
%fortran_autofree_rvalue(std::GENERATOR);
namespace std {

%rename(NAME) GENERATOR;
%rename("next") GENERATOR::operator();

class GENERATOR
{
  public:
    typedef RESULT_TYPE result_type;

    GENERATOR();
    explicit GENERATOR(result_type seed_value);
    void seed(result_type seed_value);
    void discard(unsigned long long count);
    result_type operator()();
};

} // namespace std
%enddef

/* -------------------------------------------------------------------------
 * RNG distribution routines
 * ------------------------------------------------------------------------- */

%define %flc_random_dist1(NAME, TYPE, GENERATOR, ARG1)
%inline {
static void NAME##_distribution(TYPE ARG1,
                     std::GENERATOR& g,
                     TYPE *DATA, size_t DATASIZE) {
    std::NAME##_distribution<TYPE> dist(ARG1);
    TYPE *end = DATA + DATASIZE;
    while (DATA != end) {
        *DATA++ = dist(g);
    }
}
}
%enddef

%define %flc_random_dist2(NAME, TYPE, GENERATOR, ARG1, ARG2)
%inline {
static void NAME##_distribution(TYPE ARG1, TYPE ARG2,
                     std::GENERATOR& g,
                     TYPE *DATA, size_t DATASIZE) {
    std::NAME##_distribution<TYPE> dist(ARG1, ARG2);
    TYPE *end = DATA + DATASIZE;
    while (DATA != end) {
        *DATA++ = dist(g);
    }
}
}
%enddef

#define FLC_DEFAULT_ENGINE mt19937

// Engines
%flc_random_engine(MersenneEngine4, mt19937,    int32_t)
%flc_random_engine(MersenneEngine8, mt19937_64, int64_t)

// Uniform distributions
%flc_random_dist2(uniform_int, int32_t, FLC_DEFAULT_ENGINE, left, right)
%flc_random_dist2(uniform_int, int64_t, FLC_DEFAULT_ENGINE, left, right)
%flc_random_dist2(uniform_real, double, FLC_DEFAULT_ENGINE, left, right)

// Gaussian distribution
%flc_random_dist1(normal, double, FLC_DEFAULT_ENGINE, mean)
%flc_random_dist2(normal, double, FLC_DEFAULT_ENGINE, mean, stddev)
