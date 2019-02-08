/*!
 * \file flc_algorithm.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_algorithm"
%import "flc.i"
%flc_add_header

/******************************
 * Sorting
 ******************************/

%{
#include <algorithm>
%}

%inline %{
// Sort with "less than"
template<class T>
static void sort(T *DATA, size_t SIZE) {
  std::sort(DATA, DATA + SIZE);
}
// Sort given user-provided function pointer
template<class T>
static void sort_cmp(T *DATA, size_t SIZE, bool (*cmp)(T, T)) {
  std::sort(DATA, DATA + SIZE, cmp);
}
%}

%flc_template_numeric(sort, sort)
%flc_template_numeric(sort_cmp, sort)

/******************************
 * Searching
 ******************************/

%inline {
template<class T>
int binary_search(T *DATA, size_t SIZE, T value) {
    T *end = DATA + SIZE;
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
static void shuffle(std::SWIG_MERSENNE_TWISTER& g, T *DATA, size_t SIZE) {
    std::shuffle(DATA, DATA + SIZE, g);
}
}

%flc_template_numeric(shuffle, shuffle)

