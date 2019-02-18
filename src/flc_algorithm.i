/*!
 * \file flc_algorithm.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_algorithm"
%import "flc.i"
%flc_add_header

%define %flc_cmp_algorithm(RETURN_TYPE, CONST, FUNCNAME)

%inline {
// Operate using default "less than"
template<class T>
static RETURN_TYPE FUNCNAME(CONST T *DATA, size_t DATASIZE) {
  return std::FUNCNAME(DATA, DATA + DATASIZE);
}
// Operate using user-provided function pointer
template<class T>
static RETURN_TYPE FUNCNAME ## _cmp(CONST T *DATA, size_t DATASIZE, bool (*cmp)(T, T)) {
  return std::FUNCNAME(DATA, DATA + DATASIZE, cmp);
}
}

%flc_template_numeric(FUNCNAME, FUNCNAME)
%flc_template_numeric(FUNCNAME ## _cmp, FUNCNAME)

%enddef

/******************************
 * Sorting
 ******************************/

%{
#include <algorithm>
%}

%flc_cmp_algorithm(void, , sort)
%flc_cmp_algorithm(bool, const, is_sorted)

/******************************
 * Searching
 ******************************/

%inline {
template<class T>
int binary_search(T *DATA, size_t DATASIZE, T value) {
    T *end = DATA + DATASIZE;
    auto iter = std::lower_bound(DATA, end, value);
    if (iter == end || *iter != value)
        return 0;
    // Index of the found item *IN FORTAN INDEXING
    return (iter - DATA) + 1;
}
}

%flc_template_numeric(binary_search, binary_search)

/******************************
 * Reordering
 ******************************/

%{
#include <random>
%}

%import "flc_random.i"

%inline {
template<class T>
static void shuffle(std::SWIG_MERSENNE_TWISTER& g, T *DATA, size_t DATASIZE) {
    std::shuffle(DATA, DATA + DATASIZE, g);
}
}

%flc_template_numeric(shuffle, shuffle)

