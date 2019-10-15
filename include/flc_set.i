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

/* -------------------------------------------------------------------------
 * Macro definitions
 * ------------------------------------------------------------------------- */

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
 * Numeric sets
 * ------------------------------------------------------------------------- */

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
%template(SetString) std::set<std::string>;

