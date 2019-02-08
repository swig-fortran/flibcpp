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
template<class T>
static void sort(T *DATA, size_t SIZE) {
  std::sort(DATA, DATA + SIZE);
}
%}

%flc_template_numeric(sort)

/******************************
 * TESTING FUNCTIONALITY
 ******************************/

%inline %{
template<class T, class Op>
static bool passthrough_comparator(T lhs, T rhs, Op cmp) {
  return cmp(lhs, rhs);
}
%}

#define %flc_typedef_comparator(TYPE) \
    typedef bool (*comparator_fptr_ ## TYPE)(TYPE, TYPE);
%flc_typedef_comparator(int32_t)
%flc_typedef_comparator(int64_t)
%flc_typedef_comparator(double)

%define %flc_template_comparator(NAME)
%template(NAME) NAME<int32_t, comparator_fptr_int32_t>;
%template(NAME) NAME<int64_t, comparator_fptr_int64_t>;
%template(NAME) NAME<double, comparator_fptr_double>;
%enddef

%flc_template_comparator(passthrough_comparator)
