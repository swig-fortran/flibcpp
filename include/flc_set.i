/*!
 * \file flc_set.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_set"
%include "import_flc.i"
%flc_add_header

%include <std_set.i>

// Support for set operations
%{
#include <algorithm>
#include <iterator>
%}

/* -------------------------------------------------------------------------
 * Macro definitions
 * ------------------------------------------------------------------------- */

%define %flc_define_set_algorithm(FUNCNAME)
  %insert("header") {
  template<class Set_t>
  static Set_t flc_##FUNCNAME(const Set_t& left, const Set_t& right)
  {
      Set_t result;
      std::FUNCNAME(left.begin(), left.end(),
                    right.begin(), right.end(),
                    std::inserter(result, result.end()));
      return result;
  }
  } // end %insert
%enddef

%define %flc_extend_set_algorithm(FUNCNAME, RETVAL, TYPE)
  // The rename with the stringifying macro is necessary because 'union' is a
  // keyword.
  %rename(#FUNCNAME) std::set<TYPE>::set_##FUNCNAME;
  %extend std::set<TYPE> {
   RETVAL set_##FUNCNAME(const std::set<TYPE>& other)
   { return flc_set_##FUNCNAME(*$self, other); }
  } // end %extend
%enddef

%define %flc_extend_set_pod(CTYPE)
  %apply (const SWIGTYPE *DATA, ::size_t SIZE)
    { (const CTYPE* DATA, size_type SIZE) };

  // Construct from an array of data
  set(const CTYPE* DATA, size_type SIZE) {
    return new std::set<CTYPE>(DATA, DATA + SIZE);
  }

  // Insert an array of data
  void insert(const CTYPE* DATA, size_type SIZE) {
    $self->insert(DATA, DATA + SIZE);
  }
%enddef

/* ------------------------------------------------------------------------- */
/*! \def %specialize_std_set_pod
 *
 * Inject member functions and typemaps for POD classes.
 *
 * These provide an efficient constructor from a Fortan array view. It also
 * offers a "view" functionality for getting an array pointer to the
 * set-owned data.
 *
 * This definition is considered part of the \em public API so that downstream
 * apps that generate FLC-based bindings can instantiate their own POD sets.
 */
%define %specialize_std_set_pod(T)

// Automatically free temporary sets as appropriate
%fortran_autofree_rvalue(std::set<T>);

namespace std {
  template<> class set<T> {

    SWIG_STD_SET_COMMON(set, T, std::less<T>, std::allocator<T>)
    %extend {
      %flc_extend_set_pod(T)
    }
  };
}
%enddef

/* -------------------------------------------------------------------------
 * Algorithms
 * ------------------------------------------------------------------------- */

%flc_define_set_algorithm(set_difference)
%flc_define_set_algorithm(set_intersection)
%flc_define_set_algorithm(set_symmetric_difference)
%flc_define_set_algorithm(set_union)

%insert("header") %{
template<class Set_t>
static bool flc_set_includes(const Set_t& left, const Set_t& right)
{
    return std::includes(left.begin(), left.end(),
                         right.begin(), right.end());
}
%}

%define %flc_extend_algorithms(TYPE)
  %flc_extend_set_algorithm(difference, std::set<TYPE >, TYPE)
  %flc_extend_set_algorithm(intersection, std::set<TYPE >, TYPE)
  %flc_extend_set_algorithm(symmetric_difference, std::set<TYPE >, TYPE)
  %flc_extend_set_algorithm(union, std::set<TYPE >, TYPE)
  %flc_extend_set_algorithm(includes, bool, TYPE)
%enddef

/* -------------------------------------------------------------------------
 * Numeric sets
 * ------------------------------------------------------------------------- */

%flc_extend_algorithms(int)
%specialize_std_set_pod(int)

%template(SetInt) std::set<int>;

/* -------------------------------------------------------------------------
 * String sets
 * ------------------------------------------------------------------------- */

%fortran_autofree_rvalue(std::set<std::string>);

// Allow direct insertion of a wrapped std::string
%extend std::set<std::string> {
  void insert_ref(std::string& str) {
    $self->insert(str);
  }
}

%include <std_string.i>
%import "flc_string.i"
%flc_extend_algorithms(std::string)
%template(SetString) std::set<std::string>;
