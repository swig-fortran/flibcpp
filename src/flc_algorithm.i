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
template<class T>
static void sort_cmp(T *DATA, size_t SIZE, bool (*cmp)(T, T)) {
  std::sort(DATA, DATA + SIZE, cmp);
}
%}

%flc_template_numeric(sort, sort)
%flc_template_numeric(sort_cmp, sort)

