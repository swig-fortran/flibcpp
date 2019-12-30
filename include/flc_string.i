/*!
 * \file flc_string.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_string"
%include "import_flc.i"
%flc_add_header

// SWIG always represents std::string as native strings. We load its typemaps
// but will explicitly create the class.
%include <std_string.i>

// Include typemaps for integer offsets and native integer types
%include <std_common.i>

/* -------------------------------------------------------------------------
 * Typemaps
 * ------------------------------------------------------------------------- */

// Typemap to convert positions from npos -> 0 and 1-offset otherwise. Similar
// to
%apply int FORTRAN_INT { std::size_t POSITION };
%typemap(out, noblock=1) std::size_t POSITION {
  $result = ($1 == std::string::npos ? 0 : $1 + 1);
}

/* -------------------------------------------------------------------------
 * String class definition
 * ------------------------------------------------------------------------- */

namespace std {
class string {
  public:
    // >>> TYPES
    typedef size_t size_type;
    typedef ptrdiff_t difference_type;
    typedef char value_type;
    typedef const char& const_reference;

    // Typemaps for making std::vector feel more like native Fortran:
    // - Use Fortran 1-offset indexing
    %apply int FORTRAN_INDEX {size_type pos,
                              size_type index,
                              size_type start_index,
                              size_type stop_index};
    // - Use native Fortran integers in proxy code
    %apply int FORTRAN_INT {size_type};

    // - Use fortran indexing (and 0 for not found) for search
    %apply std::size_t POSITION {size_type find};

    // - Allow access as an array view
    %apply SWIGTYPE& { string& view };
    %fortran_array_pointer(char, string& view);
    %typemap(out, noblock=1) string& view {
      $result.data = ($1->empty() ? NULL : const_cast<char*>($1->data()));
      $result.size = $1->size();
    }

    // - Allow interaction with other string objects
    %apply SWIGTYPE& {const string& OTHER};

  public:
    // >>> MEMBER FUNCTIONS

    // TODO: add more constructors
    string();
    string(size_type count, value_type ch);
    string(const std::string& s);

    // Accessors
    size_type size() const;
    bool empty() const;

    const_reference front() const;
    const_reference back() const;

    // Modify
    void resize(size_type count);
    void resize(size_type count, value_type v);
    void assign(const string& s);
    void push_back(value_type v);
    void pop_back();
    void clear();

    // String operations
    size_type find(const string& s, size_type pos = 0);
    void append(const string& s);
    int compare(const string& OTHER);

    // >>> EXTENSIONS
    // (TODO: add the same erase/insert extensions as std::vector)

    %extend {
      %fragment("SWIG_check_range");

      void set(size_type index, value_type v) {
        SWIG_check_range(index, $self->size(),
                         "std::string::set",
                         return);
        (*$self)[index] = v;
      }

      value_type get(size_type index) {
        SWIG_check_range(index, $self->size(),
                         "std::string::get",
                         return $self->front());
        return (*$self)[index];
      }

      // Get a character array view
      string& view() { return *$self; }

      // Get a copy as a native Fortran string
      const string& str() { return *$self; }
    }
};

/* -------------------------------------------------------------------------
 * String conversion routines
 * ------------------------------------------------------------------------- */

%exception {
  SWIG_check_unhandled_exception();
  try {
    $action
  }
  catch (const std::invalid_argument& e) {
    SWIG_exception(SWIG_ValueError, e.what());
  }
  catch (const std::out_of_range& e) {
    SWIG_exception(SWIG_OverflowError, e.what());
  }
}

%fragment("flc_has_junk", "header",
          fragment="<cctype>", fragment="<algorithm>") %{
  SWIGINTERN bool flc_has_junk(const std::string& s, size_t pos) {
    return !std::all_of(s.begin() + pos, s.end(),
                        [](unsigned char c) -> bool { return std::isspace(c); });
  }
%}

%typemap(in, numinputs=0, noblock=1) size_t* result_pos (size_t temp_pos) {
  temp_pos = 0;
  $1 = &temp_pos;
}
%typemap(argout, noblock=1, fragment="flc_has_junk") size_t* result_pos {
  if (flc_has_junk(*arg1, temp_pos$argnum)) {
    SWIG_exception(SWIG_ValueError, "Junk at end of string");
  }
}

// String conversion routines
#define %add_string_int_conversion(RETURN_TYPE, NAME) \
  RETURN_TYPE NAME(const string& s, size_t* result_pos, int base = 10)
#define %add_string_real_conversion(RETURN_TYPE, NAME) \
  RETURN_TYPE NAME(const string& s, size_t* result_pos)

%add_string_int_conversion(int, stoi);
%add_string_int_conversion(long, stol);
%add_string_int_conversion(long long, stoll);
%add_string_real_conversion(float, stof);
%add_string_real_conversion(double, stod);

// Don't add exception code for subsequent functions
%exception;

} // namespace std
