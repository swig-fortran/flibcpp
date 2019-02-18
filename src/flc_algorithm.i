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
 * Finding sorted indices
 ******************************/

%apply (SWIGTYPE *DATA, size_t SIZE) { (int *idx, size_t idx_size) };

%{
#include <numeric>
#include <functional>

template<class T, class Compare>
static void argsort_impl(const T *data, size_t size,
                         int *index, size_t index_size,
                         Compare cmp) {
  // Fill invalid indices with zero
  if (size < index_size) {
    std::fill(index + size, index + index_size, 0);
  }
  size = std::min(size, index_size);
  // Fill the indices with 1 through size
  std::iota(index, index + size, 1);
  // Define a comparator that accesses the original data
  auto int_sort_cmp = [cmp, data](int left, int right)
  { return cmp(data[left - 1], data[right - 1]); };
  // Let the standard library do all the hard work!
  std::sort(index, index + size, int_sort_cmp);
}
%}

%inline %{
template<class T>
static void argsort(const T *DATA, size_t DATASIZE, int *idx, size_t idx_size) {
  return argsort_impl(DATA, DATASIZE, idx, idx_size, std::less<T>());
}

template<class T>
static void argsort_cmp(const T *DATA, size_t DATASIZE,
                        int *idx, size_t idx_size,
                        bool (*cmp)(T, T)) {
  return argsort_impl(DATA, DATASIZE, idx, idx_size, cmp);
}
%}

%flc_template_numeric(argsort, argsort)
%flc_template_numeric(argsort_cmp, argsort)

/******************************
 * Searching
 ******************************/

%{
template<class T, class Compare>
static int binary_search_impl(const T *data, size_t size, T value, Compare cmp) {
  const T *end = data + size;
  auto iter = std::lower_bound(data, end, value, cmp);
  if (iter == end || cmp(*iter, value) || cmp(value, *iter))
      return 0;
  // Index of the found item *IN FORTAN INDEXING*
  return (iter - data) + 1;
}
%}

%inline %{
template<class T>
static int binary_search(const T *DATA, size_t DATASIZE, T value) {
  return binary_search_impl(DATA, DATASIZE, value, std::less<T>());
}

template<class T>
static int binary_search_cmp(const T *DATA, size_t DATASIZE, T value,
                        bool (*cmp)(T, T)) {
  return binary_search_impl(DATA, DATASIZE, value, cmp);
}
%}

%flc_template_numeric(binary_search, binary_search)
%flc_template_numeric(binary_search_cmp, binary_search)

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

