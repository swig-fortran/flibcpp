/*!
 * \file flc.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc"

#if defined(SWIGIMPORTED) && !defined(SWIGIMPORTED)
#error "To import the FLC module correctly, use ``%include \"import_flc.i\"``"
#endif

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

/************************
 * Exception handling
 ************************/

/* Rename the error variables' internal C symbols */
#define SWIG_FORTRAN_ERROR_INT flc_ierr
#define SWIG_FORTRAN_ERROR_STR flc_get_serr

/* Restore names in the wrapper code */
%rename(ierr) flc_ierr;
%rename(get_serr) flc_get_serr;

/* Unless we're directly building this module, delay exception handling */
#ifndef SWIGIMPORTED
%include <exception.i>
#endif

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
       (int32_t  *DATA, size_t DATASIZE),
       (int64_t  *DATA, size_t DATASIZE),
       (double   *DATA, size_t DATASIZE) };

%apply (const SWIGTYPE *DATA, size_t SIZE) {
       (const int32_t  *DATA, size_t DATASIZE),
       (const int64_t  *DATA, size_t DATASIZE),
       (const double   *DATA, size_t DATASIZE) };

/************************
 * Version information
 *
 * Linked into auto-generated file flibcpp_version.cpp
 ************************/

%apply char* { const char flibcpp_version[] };
%fortranbindc flibcpp_version_major;
%fortranbindc flibcpp_version_minor;
%fortranbindc flibcpp_version_patch;

%inline %{
extern "C" {
extern const char flibcpp_version[];
extern const int flibcpp_version_major;
extern const int flibcpp_version_minor;
extern const int flibcpp_version_patch;
}
%}
