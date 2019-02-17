/*!
 * \file flc.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc"

%define %flc_add_header
%insert("fbegin") %{
! Flibcpp project, https://github.com/swig-fortran/flibcpp
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
%}
%insert("begin") %{
/*
 * Flibcpp project, https://github.com/swig-fortran/flibcpp
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */
%}
%enddef

%flc_add_header

/******************************
 * Data types and instantiation
 ******************************/
%{
#include <cstdint>
using std::int32_t;
using std::int64_t;
using std::size_t;
%}
%include <stdint.i>

%define %flc_template_numeric(SRC, DST)
%template(DST) SRC<int32_t>;
%template(DST) SRC<int64_t>;
%template(DST) SRC<double>;
%enddef

/************************
 * Array view translation
 ************************/

%include <typemaps.i>
%apply (SWIGTYPE *DATA, size_t SIZE) {
       (int32_t *DATA, size_t SIZE),
       (int64_t *DATA, size_t SIZE),
       (double  *DATA, size_t SIZE) };
