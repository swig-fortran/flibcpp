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
#if defined(_MSC_VER) && _MSC_VER < 1900
// Visual studio 2012's standard library lacks iterator constructors for
// std::discrete_distribution
#define FLC_MISSING_DISCRETE_ITER
#endif
%}

/* -------------------------------------------------------------------------
 * Macros
 * ------------------------------------------------------------------------- */

%define %flc_random_engine(NAME, GENERATOR, RESULT_TYPE)
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

%{
template<class D, class G, class T>
static inline void flc_generate(D dist, G& g, T* data, size_t size) {
  T* const end = data + size;
  while (data != end) {
    *data++ = dist(g);
  }
}
%}

%apply (const SWIGTYPE *DATA, size_t SIZE) {
       (const double *WEIGHTS, size_t WEIGHTSIZE) };

%inline %{
template<class T, class G>
static void uniform_int_distribution(T left, T right,
                                     G& engine, T* DATA, size_t DATASIZE) {
  flc_generate(std::uniform_int_distribution<T>(left, right),
               engine, DATA, DATASIZE);
}

template<class T, class G>
static void uniform_real_distribution(T left, T right,
                                      G& engine, T* DATA, size_t DATASIZE) {
  flc_generate(std::uniform_real_distribution<T>(left, right),
               engine, DATA, DATASIZE);
}

template<class T, class G>
static void normal_distribution(T mean, T stddev,
                                G& engine, T* DATA, size_t DATASIZE) {
  flc_generate(std::normal_distribution<T>(mean, stddev),
               engine, DATA, DATASIZE);
}

template<class T, class G>
static void discrete_distribution(const double* WEIGHTS, size_t WEIGHTSIZE,
                                  G& engine, T* DATA, size_t DATASIZE) {
#ifndef FLC_MISSING_DISCRETE_ITER
  std::discrete_distribution<T> dist(WEIGHTS, WEIGHTS + WEIGHTSIZE);
#else
  std::discrete_distribution<T> dist(
      std::initializer_list<double>(WEIGHTS, WEIGHTS + WEIGHTSIZE));
#endif
  T* const end = DATA + DATASIZE;
  while (DATA != end) {
    *DATA++ = dist(engine) + 1; // Note: transform to Fortran 1-offset
  }
}
%}

%define %flc_distribution(NAME, STDENGINE, TYPE)
%template(NAME##_distribution) NAME##_distribution< TYPE, std::STDENGINE >;
%enddef

// Engines
%flc_random_engine(MersenneEngine4, mt19937,    int32_t)
%flc_random_engine(MersenneEngine8, mt19937_64, int64_t)

#define FLC_DEFAULT_ENGINE mt19937
%flc_distribution(uniform_int,  FLC_DEFAULT_ENGINE, int32_t)
%flc_distribution(uniform_int,  FLC_DEFAULT_ENGINE, int64_t)
%flc_distribution(uniform_real, FLC_DEFAULT_ENGINE, double)

%flc_distribution(normal, FLC_DEFAULT_ENGINE, double)

// Discrete sampling distribution
%flc_distribution(discrete, FLC_DEFAULT_ENGINE, int32_t)
%flc_distribution(discrete, FLC_DEFAULT_ENGINE, int64_t)
