/*!
 * \file flc_vector.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_vector"
%include "import_flc.i"
%flc_add_header

%include <std_vector.i>

/* -------------------------------------------------------------------------
 * Macro definitions
 * ------------------------------------------------------------------------- */

%define %flc_std_vector_extend_pod(CTYPE)
%extend {
  %apply (const SWIGTYPE *DATA, ::size_t SIZE)
    { (const CTYPE* DATA, size_type SIZE) };

  // Construct from an array of data
  vector(const CTYPE* DATA, size_type SIZE) {
    return new std::vector<CTYPE>(DATA, DATA + SIZE);
  }

  // Assign from another vector
  void assign(const CTYPE* DATA, size_type SIZE) {
    $self->assign(DATA, DATA + SIZE);
  }

  // Get a mutable view to ourself
  %fortran_array_pointer(CTYPE, vector<CTYPE>& view);

  %typemap(out, noblock=1) vector<CTYPE>& view {
    $result.data = ($1->empty() ? NULL : &(*$1->begin()));
    $result.size = $1->size();
  }

  vector<CTYPE>& view() {
    return *$self;
  }
}
%enddef

/* ------------------------------------------------------------------------- */
/*! \def %flc_template_std_vector_pod
 *
 * Inject member functions and typemaps for POD classes, and instantiate.
 *
 * The added methods provide an efficient constructor from a Fortan array view.
 * It also offers a "view" functionality for getting an array pointer to the
 * vector-owned data.
 *
 * This definition is considered part of the \em public API so that downstream
 * apps that generate FLC-based bindings can instantiate their own POD vectors.
 */
%define %flc_template_std_vector_pod(NAME, T)

namespace std {
  template<> class vector<T> {

    %swig_std_vector(T, const T&)
    %swig_std_vector_extend_ref(T)
    %flc_std_vector_extend_pod(T)
  };
}

// Instantiate the template
%template(NAME) std::vector<T>;

%enddef

/* -------------------------------------------------------------------------
 * Numeric vectors
 * ------------------------------------------------------------------------- */

%flc_template_std_vector_pod(VectorInt4,  int32_t)
%flc_template_std_vector_pod(VectorInt8,  int64_t)
%flc_template_std_vector_pod(VectorReal8, double)

/* -------------------------------------------------------------------------
 * String vectors
 * ------------------------------------------------------------------------- */

%include <std_string.i>
%import "flc_string.i"

%apply SWIGTYPE& { const std::string& value };

%extend std::vector<std::string> {
  void set_ref(size_type index, const std::string& value) {
    SWIG_check_range(index, $self->size(),
                     "std::vector<std::string>::set_ref",
                     return);
    (*$self)[index] = value;
  }
}

%template(VectorString) std::vector<std::string>;

%clear const std::string& value;
