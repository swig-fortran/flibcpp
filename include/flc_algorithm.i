/*!
 * \file flc_algorithm.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_algorithm"
%include "import_flc.i"
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
  return FUNCNAME##_impl(CALL, std::less<T>());
}
// Operate using user-provided function pointer
template<class T>
static RETURN_TYPE FUNCNAME##_cmp(ARGS, bool (*cmp)(T, T)) {
  return FUNCNAME##_impl(CALL, cmp);
}
}

// Instantiate numeric overloads
%flc_template_numeric(FUNCNAME, FUNCNAME)
%flc_template_numeric(FUNCNAME##_cmp, FUNCNAME)

// Instantiate comparators with void* arguments
%template(FUNCNAME) FUNCNAME##_cmp<void*>;

%enddef

// >>> Create a native function pointer interface for the given comparator.

%define %flc_cmp_funptr(CTYPE, FTYPE)

#define flc_cmp_funptr flc_cmp_funptr_ ## %mangle(CTYPE)

// Define an abstract interface that gets inserted into the module
%fragment("flc_cmp_funptr"{CTYPE}, "fdecl", noblock=1)
{ abstract interface
   function flc_cmp_funptr(left, right) bind(C) &
       result(fresult)
     use, intrinsic :: ISO_C_BINDING
     FTYPE, intent(in), value :: left, right
     logical(C_BOOL) :: fresult
   end function
 end interface}

%apply bool (*)(SWIGTYPE, SWIGTYPE) { bool (*)(CTYPE, CTYPE) };
%typemap(ftype, in={procedure(flc_cmp_funptr)},
         fragment="flc_cmp_funptr"{CTYPE}, noblock=1) bool (*)(CTYPE, CTYPE)
  {procedure(flc_cmp_funptr), pointer}

#undef SWIG_cmp_funptr

%enddef

/* -------------------------------------------------------------------------
 * Types
 * ------------------------------------------------------------------------- */

// Alias the native C integer to an "indexing" integer returned by algorithm
// functions.
%inline %{
typedef int index_int;
%}
%insert("fdecl") %{integer, parameter, public :: INDEX_INT = C_INT
%}

// Give it a particularly named type in the Fortran proxy code.
%apply int { index_int };
%typemap(ftype, in={integer(INDEX_INT), intent(in)}) index_int
  %{integer(INDEX_INT)%}

// Apply array-to-C translation for numeric values
%apply (SWIGTYPE *DATA, size_t SIZE) { (index_int *IDX, size_t IDXSIZE) };

%apply (const SWIGTYPE *DATA, size_t SIZE) {
       (const int32_t  *DATA1, size_t DATASIZE1),
       (const int64_t  *DATA1, size_t DATASIZE1),
       (const double   *DATA1, size_t DATASIZE1),
       (const void    **DATA1, size_t DATASIZE1),
       (const int32_t  *DATA2, size_t DATASIZE2),
       (const int64_t  *DATA2, size_t DATASIZE2),
       (const double   *DATA2, size_t DATASIZE2),
       (const void    **DATA2, size_t DATASIZE2)};


// Make function pointers available as generic types
%typemap(fin) bool (*)(SWIGTYPE, SWIGTYPE)
  "$1 = c_funloc($input)"
%typemap(findecl, match="fin") bool (*)(SWIGTYPE, SWIGTYPE) ""
%typemap(fout) bool (*)(CTYPE, CTYPE)
  "call c_f_procpointer($1, $result)"
%typemap(foutdecl, match="fout") bool (*)(SWIGTYPE, SWIGTYPE) ""

%flc_cmp_funptr(int32_t,   integer(C_INT32_T))
%flc_cmp_funptr(int64_t,   integer(C_INT64_T))
%flc_cmp_funptr(double,    real(C_DOUBLE))
%flc_cmp_funptr(index_int, integer(INDEX_INT))
%flc_cmp_funptr(void*,     type(C_PTR))

/* -------------------------------------------------------------------------
 * Sorting routines
 * ------------------------------------------------------------------------- */

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

%flc_cmp_algorithm(void, sort,
                   %arg(T *DATA, size_t DATASIZE),
                   %arg(DATA, DATASIZE))
%flc_cmp_algorithm(bool, is_sorted,
                   %arg(const T *DATA, size_t DATASIZE),
                   %arg(DATA, DATASIZE))
%flc_cmp_algorithm(void, argsort,
                   %arg(const T *DATA, size_t DATASIZE,
                        index_int *IDX, size_t IDXSIZE),
                   %arg(DATA, DATASIZE, IDX, IDXSIZE))

/* -------------------------------------------------------------------------
 * Searching routines
 * ------------------------------------------------------------------------- */

%{
template<class T, class Compare>
static index_int binary_search_impl(const T *data, size_t size, T value,
                                    Compare cmp) {
  const T *end = data + size;
  auto iter = std::lower_bound(data, end, value, cmp);
  if (iter == end || cmp(*iter, value) || cmp(value, *iter))
    return 0;
  // Index of the found item *IN FORTAN INDEXING*
  return (iter - data) + 1;
}

template<class T, class Compare>
static void equal_range_impl(const T *data, size_t size, T value,
                             index_int &first_index, index_int &last_index,
                             Compare cmp) {
  const T *end = data + size;
  auto range_pair = std::equal_range(data, end, value, cmp);
  // Index of the min/max items *IN FORTAN INDEXING*
  first_index = range_pair.first - data + 1;
  last_index = range_pair.second - data;
}

template<class T, class Compare>
static void minmax_element_impl(const T *data, size_t size,
                                index_int &min_index, index_int &max_index,
                                Compare cmp) {
  const T *end = data + size;
  auto mm_pair = std::minmax_element(data, end, cmp);
  // Index of the min/max items *IN FORTAN INDEXING*
  min_index = mm_pair.first - data + 1;
  max_index = mm_pair.second - data + 1;
}
%}

%flc_cmp_algorithm(index_int, binary_search,
                   %arg(const T *DATA, size_t DATASIZE, T value),
                   %arg(DATA, DATASIZE, value))

%flc_cmp_algorithm(void, equal_range,
                   %arg(const T *DATA, size_t DATASIZE, T value,
                        index_int &first_index, index_int &last_index),
                   %arg(DATA, DATASIZE, value, first_index, last_index))

%flc_cmp_algorithm(void, minmax_element,
                   %arg(const T *DATA, size_t DATASIZE,
                        index_int &min_index, index_int &max_index),
                   %arg(DATA, DATASIZE, min_index, max_index))

/* -------------------------------------------------------------------------
 * Set operation routines
 * ------------------------------------------------------------------------- */

%{
template<class T, class Compare>
static bool includes_impl(const T *data1, size_t size1,
                          const T *data2, size_t size2,
                          Compare cmp) {
  return std::includes(data1, data1 + size1, data2, data2 + size2, cmp);
}
%}

%flc_cmp_algorithm(bool, includes,
                   %arg(const T *DATA1, size_t DATASIZE1,
                        const T *DATA2, size_t DATASIZE2),
                   %arg(DATA1, DATASIZE1, DATA2, DATASIZE2))

/* -------------------------------------------------------------------------
 * Modifying routines
 * ------------------------------------------------------------------------- */

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
%template(shuffle) shuffle<void*>;
