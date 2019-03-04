/*!
 * \file flc_algorithm.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_algorithm"
%import "flc.i"
%flc_add_header

%{
#include <algorithm>
#include <functional>
#include <numeric>
%}

%define %flc_cmp_algorithm(RETURN_TYPE, FUNCNAME, ARGS, CALL)

%inline {
// Operate using default "less than"
template<class T>
static RETURN_TYPE FUNCNAME(ARGS) {
  return FUNCNAME ## _impl(CALL, std::less<T>());
}
// Operate using user-provided function pointer
template<class T>
static RETURN_TYPE FUNCNAME ## _cmp(ARGS, bool (*cmp)(T, T)) {
  return FUNCNAME ## _impl(CALL, cmp);
}
}

%flc_template_numeric(FUNCNAME, FUNCNAME)
%flc_template_numeric(FUNCNAME ## _cmp, FUNCNAME)

%enddef

/******************************
 * Types
 ******************************/

%inline %{
typedef int index_int;
%}
%insert("fdecl") %{integer, parameter, public :: INDEX_INT = C_INT
%}

%apply int { index_int };
%typemap(ftype, in={integer(INDEX_INT), intent(in)}) index_int
   %{integer(INDEX_INT)%}

/******************************
 * Sorting
 ******************************/

%apply (SWIGTYPE *DATA, size_t SIZE) { (index_int *IDX, size_t IDXSIZE) };

%{
template<class T, class Compare>
static void sort_impl(T *data, size_t size, Compare cmp) {
    return std::sort(data, data + size, cmp);
}

template<class T, class Compare>
static bool is_sorted_impl(const T *data, size_t size, Compare cmp) {
    return std::is_sorted(data, data + size, cmp);
}

template<class T, class Compare>
static void argsort_impl(const T *data, size_t size,
                         index_int *index, size_t index_size,
                         Compare cmp) {
  // Fill invalid indices with zero
  if (size < index_size) {
    std::fill(index + size, index + index_size, 0);
  }
  size = std::min(size, index_size);
  // Fill the indices with 1 through size
  std::iota(index, index + size, 1);
  // Define a comparator that accesses the original data
  auto int_sort_cmp = [cmp, data](index_int left, index_int right)
  { return cmp(data[left - 1], data[right - 1]); };
  // Let the standard library do all the hard work!
  std::sort(index, index + size, int_sort_cmp);
}

%}

%flc_cmp_algorithm(void, sort, %arg(T *DATA, size_t DATASIZE),
                   %arg(DATA, DATASIZE))
%flc_cmp_algorithm(bool, is_sorted, %arg(const T *DATA, size_t DATASIZE),
                   %arg(DATA, DATASIZE))
%flc_cmp_algorithm(void, argsort, %arg(const T *DATA, size_t DATASIZE,
                                       index_int *IDX, size_t IDXSIZE),
                   %arg(DATA, DATASIZE, IDX, IDXSIZE))

/******************************
 * Searching
 ******************************/

%{
template<class T, class Compare>
static index_int binary_search_impl(const T *data, size_t size, T value, Compare cmp) {
  const T *end = data + size;
  auto iter = std::lower_bound(data, end, value, cmp);
  if (iter == end || cmp(*iter, value) || cmp(value, *iter))
    return 0;
  // Index of the found item *IN FORTAN INDEXING*
  return (iter - data) + 1;
}
%}

%flc_cmp_algorithm(index_int, binary_search, %arg(const T *DATA, size_t DATASIZE,
                                            T value),
                   %arg(DATA, DATASIZE, value))

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

