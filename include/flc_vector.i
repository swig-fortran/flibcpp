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

/* ------------------------------------------------------------------------- */
%define EXTEND_STD_VECTOR_POD(CTYPE)
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
%enddef

/* ------------------------------------------------------------------------- */
/*! \def EXTEND_STD_VECTOR_POD_INTERNAL
 *
 * Inject member functions and typemaps for POD classes.
 *
 * These provide an efficient constructor from a Fortan array view. It also
 * offers a "view" functionality for getting an array pointer to the
 * vector-owned data.
 */
%define %specialize_std_vector_pod(T)
namespace std {
  template<> class vector<T> {
    // Automatically free temporary vectors as appropriate
    %fortran_autofree_rvalue(std::vector<T>);

    SWIG_STD_VECTOR_COMMON(T, const T&)
    SWIG_STD_VECTOR_REF(T)
    %extend {
      EXTEND_STD_VECTOR_POD(T)
    }
  };
}
%enddef

/* ------------------------------------------------------------------------- */

%specialize_std_vector_pod(int32_t)
%specialize_std_vector_pod(int64_t)
%specialize_std_vector_pod(double)

%template(VectorInt4) std::vector<int32_t>;
%template(VectorInt8) std::vector<int64_t>;
%template(VectorReal8) std::vector<double>;

/* ------------------------------------------------------------------------- */

%fortran_autofree_rvalue(std::vector<std::string>);
%extend std::vector<std::string> {
  void set_ref(size_type index, std::string& str) {
    SWIG_check_range(index, $self->size(),
                     "std::vector<std::string>::set_ref",
                     return);
    (*$self)[index] = str;
  }
}

%include <std_string.i>
%import "flc_string.i"
%template(VectorString) std::vector<std::string>;
