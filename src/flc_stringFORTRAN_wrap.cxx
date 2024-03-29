/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (https://www.swig.org).
 * Version 4.1.1+fortran
 *
 * Do not make changes to this file unless you know what you are doing - modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

/*
 * Flibcpp project, https://github.com/swig-fortran/flibcpp
 * Copyright (c) 2019-2020 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

/* -----------------------------------------------------------------------------
 *  This section contains generic SWIG labels for method/variable
 *  declarations/attributes, and other compiler dependent labels.
 * ----------------------------------------------------------------------------- */

/* template workaround for compilers that cannot correctly implement the C++ standard */
#ifndef SWIGTEMPLATEDISAMBIGUATOR
# if defined(__SUNPRO_CC) && (__SUNPRO_CC <= 0x560)
#  define SWIGTEMPLATEDISAMBIGUATOR template
# elif defined(__HP_aCC)
/* Needed even with `aCC -AA' when `aCC -V' reports HP ANSI C++ B3910B A.03.55 */
/* If we find a maximum version that requires this, the test would be __HP_aCC <= 35500 for A.03.55 */
#  define SWIGTEMPLATEDISAMBIGUATOR template
# else
#  define SWIGTEMPLATEDISAMBIGUATOR
# endif
#endif

/* inline attribute */
#ifndef SWIGINLINE
# if defined(__cplusplus) || (defined(__GNUC__) && !defined(__STRICT_ANSI__))
#   define SWIGINLINE inline
# else
#   define SWIGINLINE
# endif
#endif

/* attribute recognised by some compilers to avoid 'unused' warnings */
#ifndef SWIGUNUSED
# if defined(__GNUC__)
#   if !(defined(__cplusplus)) || (__GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4))
#     define SWIGUNUSED __attribute__ ((__unused__))
#   else
#     define SWIGUNUSED
#   endif
# elif defined(__ICC)
#   define SWIGUNUSED __attribute__ ((__unused__))
# else
#   define SWIGUNUSED
# endif
#endif

#ifndef SWIG_MSC_UNSUPPRESS_4505
# if defined(_MSC_VER)
#   pragma warning(disable : 4505) /* unreferenced local function has been removed */
# endif
#endif

#ifndef SWIGUNUSEDPARM
# ifdef __cplusplus
#   define SWIGUNUSEDPARM(p)
# else
#   define SWIGUNUSEDPARM(p) p SWIGUNUSED
# endif
#endif

/* internal SWIG method */
#ifndef SWIGINTERN
# define SWIGINTERN static SWIGUNUSED
#endif

/* internal inline SWIG method */
#ifndef SWIGINTERNINLINE
# define SWIGINTERNINLINE SWIGINTERN SWIGINLINE
#endif

/* exporting methods */
#if defined(__GNUC__)
#  if (__GNUC__ >= 4) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
#    ifndef GCC_HASCLASSVISIBILITY
#      define GCC_HASCLASSVISIBILITY
#    endif
#  endif
#endif

#ifndef SWIGEXPORT
# if defined(_WIN32) || defined(__WIN32__) || defined(__CYGWIN__)
#   if defined(STATIC_LINKED)
#     define SWIGEXPORT
#   else
#     define SWIGEXPORT __declspec(dllexport)
#   endif
# else
#   if defined(__GNUC__) && defined(GCC_HASCLASSVISIBILITY)
#     define SWIGEXPORT __attribute__ ((visibility("default")))
#   else
#     define SWIGEXPORT
#   endif
# endif
#endif

/* calling conventions for Windows */
#ifndef SWIGSTDCALL
# if defined(_WIN32) || defined(__WIN32__) || defined(__CYGWIN__)
#   define SWIGSTDCALL __stdcall
# else
#   define SWIGSTDCALL
# endif
#endif

/* Deal with Microsoft's attempt at deprecating C standard runtime functions */
#if !defined(SWIG_NO_CRT_SECURE_NO_DEPRECATE) && defined(_MSC_VER) && !defined(_CRT_SECURE_NO_DEPRECATE)
# define _CRT_SECURE_NO_DEPRECATE
#endif

/* Deal with Microsoft's attempt at deprecating methods in the standard C++ library */
#if !defined(SWIG_NO_SCL_SECURE_NO_DEPRECATE) && defined(_MSC_VER) && !defined(_SCL_SECURE_NO_DEPRECATE)
# define _SCL_SECURE_NO_DEPRECATE
#endif

/* Deal with Apple's deprecated 'AssertMacros.h' from Carbon-framework */
#if defined(__APPLE__) && !defined(__ASSERT_MACROS_DEFINE_VERSIONS_WITHOUT_UNDERSCORES)
# define __ASSERT_MACROS_DEFINE_VERSIONS_WITHOUT_UNDERSCORES 0
#endif

/* Intel's compiler complains if a variable which was never initialised is
 * cast to void, which is a common idiom which we use to indicate that we
 * are aware a variable isn't used.  So we just silence that warning.
 * See: https://github.com/swig/swig/issues/192 for more discussion.
 */
#ifdef __INTEL_COMPILER
# pragma warning disable 592
#endif


#ifndef SWIGEXTERN
# ifdef __cplusplus
#   define SWIGEXTERN extern
# else
#   define SWIGEXTERN
# endif
#endif


#define SWIG_exception_impl(DECL, CODE, MSG, RETURNNULL) \
 { throw std::logic_error("In " DECL ": " MSG); }


#ifdef __cplusplus
extern "C" {
#endif
SWIGEXPORT void SWIG_check_unhandled_exception_impl(const char* decl);
SWIGEXPORT void SWIG_store_exception(const char* decl, int errcode, const char *msg);
#ifdef __cplusplus
}
#endif


#undef SWIG_exception_impl
#define SWIG_exception_impl(DECL, CODE, MSG, RETURNNULL) \
    SWIG_store_exception(DECL, CODE, MSG); RETURNNULL;

/* SWIG Errors applicable to all language modules, values are reserved from -1 to -99 */
#define  SWIG_UnknownError    	   -1
#define  SWIG_IOError        	   -2
#define  SWIG_RuntimeError   	   -3
#define  SWIG_IndexError     	   -4
#define  SWIG_TypeError      	   -5
#define  SWIG_DivisionByZero 	   -6
#define  SWIG_OverflowError  	   -7
#define  SWIG_SyntaxError    	   -8
#define  SWIG_ValueError     	   -9
#define  SWIG_SystemError    	   -10
#define  SWIG_AttributeError 	   -11
#define  SWIG_MemoryError    	   -12
#define  SWIG_NullReferenceError   -13



enum SwigMemFlags {
    SWIG_MEM_OWN = 0x01,
    SWIG_MEM_RVALUE = 0x02,
};


#define SWIG_check_nonnull(PTR, TYPENAME, FNAME, FUNCNAME, RETURNNULL) \
  if (!(PTR)) { \
    SWIG_exception_impl(FUNCNAME, SWIG_NullReferenceError, \
                        "Cannot pass null " TYPENAME " (class " FNAME ") " \
                        "as a reference", RETURNNULL); \
  }


#define SWIG_check_range(INDEX, SIZE, FUNCNAME, RETURNNULL) \
  if (!(INDEX < SIZE)) { \
    SWIG_exception_impl(FUNCNAME, SWIG_IndexError, \
                        "index out of range", RETURNNULL); \
  }


namespace swig {
enum AssignmentType {
  ASSIGNMENT_DEFAULT,
  ASSIGNMENT_NODESTRUCT,
  ASSIGNMENT_SMARTPTR
};
}



#define SWIG_VERSION 0x040101
#define SWIGFORTRAN
#define SWIGPOLICY_std_string swig::ASSIGNMENT_DEFAULT

#ifdef __cplusplus
#include <utility>
/* SwigValueWrapper is described in swig.swg */
template<typename T> class SwigValueWrapper {
  struct SwigSmartPointer {
    T *ptr;
    SwigSmartPointer(T *p) : ptr(p) { }
    ~SwigSmartPointer() { delete ptr; }
    SwigSmartPointer& operator=(SwigSmartPointer& rhs) { T* oldptr = ptr; ptr = 0; delete oldptr; ptr = rhs.ptr; rhs.ptr = 0; return *this; }
    void reset(T *p) { T* oldptr = ptr; ptr = 0; delete oldptr; ptr = p; }
  } pointer;
  SwigValueWrapper& operator=(const SwigValueWrapper<T>& rhs);
  SwigValueWrapper(const SwigValueWrapper<T>& rhs);
public:
  SwigValueWrapper() : pointer(0) { }
  SwigValueWrapper& operator=(const T& t) { SwigSmartPointer tmp(new T(t)); pointer = tmp; return *this; }
#if __cplusplus >=201103L
  SwigValueWrapper& operator=(T&& t) { SwigSmartPointer tmp(new T(std::move(t))); pointer = tmp; return *this; }
  operator T&&() const { return std::move(*pointer.ptr); }
#else
  operator T&() const { return *pointer.ptr; }
#endif
  T *operator&() const { return pointer.ptr; }
  static void reset(SwigValueWrapper& t, T *p) { t.pointer.reset(p); }
};

/*
 * SwigValueInit() is a generic initialisation solution as the following approach:
 * 
 *       T c_result = T();
 * 
 * doesn't compile for all types for example:
 * 
 *       unsigned int c_result = unsigned int();
 */
template <typename T> T SwigValueInit() {
  return T();
}

#if __cplusplus >=201103L
# define SWIG_STD_MOVE(OBJ) std::move(OBJ)
#else
# define SWIG_STD_MOVE(OBJ) OBJ
#endif

#endif


#include <stdexcept>


/* Support for the `contract` feature.
 *
 * Note that RETURNNULL is first because it's inserted via a 'Replaceall' in
 * the fortran.cxx file.
 */
#define SWIG_contract_assert(RETURNNULL, EXPR, MSG) \
 if (!(EXPR)) { SWIG_exception_impl("$decl", SWIG_ValueError, MSG, RETURNNULL); } 


#define SWIG_as_voidptr(a) const_cast< void * >(static_cast< const void * >(a)) 
#define SWIG_as_voidptrptr(a) ((void)SWIG_as_voidptr(*a),reinterpret_cast< void** >(a)) 


#include <stdint.h>


#include <string>


struct SwigClassWrapper {
    void* cptr;
    int cmemflags;
};


SWIGINTERN SwigClassWrapper SwigClassWrapper_uninitialized() {
    SwigClassWrapper result;
    result.cptr = NULL;
    result.cmemflags = 0;
    return result;
}


#include <stdlib.h>
#ifdef _MSC_VER
# ifndef strtoull
#  define strtoull _strtoui64
# endif
# ifndef strtoll
#  define strtoll _strtoi64
# endif
#endif


struct SwigArrayWrapper {
    void* data;
    size_t size;
};


SWIGINTERN SwigArrayWrapper SwigArrayWrapper_uninitialized() {
  SwigArrayWrapper result;
  result.data = NULL;
  result.size = 0;
  return result;
}

SWIGINTERN void std_string_set(std::string *self,std::string::size_type index,std::string::value_type v){
        SWIG_check_range(index, self->size(),
                         "std::string::set",
                         return);
        (*self)[index] = v;
      }
SWIGINTERN std::string::value_type std_string_get(std::string *self,std::string::size_type index){
        SWIG_check_range(index, self->size(),
                         "std::string::get",
                         return self->front());
        return (*self)[index];
      }
SWIGINTERN std::string &std_string_view(std::string *self){ return *self; }
SWIGINTERN std::string const &std_string_str(std::string *self){ return *self; }

#include <string.h>


namespace swig {

template<class T, AssignmentType A>
struct DestructorPolicy {
  static SwigClassWrapper destroy(SwigClassWrapper self) {
    delete static_cast<T*>(self.cptr);
    return SwigClassWrapper_uninitialized();
  }
};
template<class T>
struct DestructorPolicy<T, ASSIGNMENT_NODESTRUCT> {
  static SwigClassWrapper destroy(SwigClassWrapper) {
    SWIG_exception_impl("assignment", SWIG_TypeError, "Invalid assignment: class type has private destructor", return SwigClassWrapper_uninitialized());
  }
};
}


namespace swig {

SWIGINTERN SwigClassWrapper capture(SwigClassWrapper other) {
  other.cmemflags &= ~SWIG_MEM_RVALUE;
  return other;
}

template<class T, AssignmentType A>
struct AssignmentPolicy {
  static SwigClassWrapper destroy(SwigClassWrapper self) {
    return DestructorPolicy<T, A>::destroy(self);
  }
  static SwigClassWrapper alias(SwigClassWrapper other) {
    SwigClassWrapper self = other;
    self.cmemflags &= ~SWIG_MEM_OWN;
    return self;
  }
  static SwigClassWrapper move_alias(SwigClassWrapper self, SwigClassWrapper other) {
    if (self.cmemflags & SWIG_MEM_OWN) {
      destroy(self);
    }
    return capture(other);
  }
  static SwigClassWrapper copy_alias(SwigClassWrapper self, SwigClassWrapper other) {
    if (self.cmemflags & SWIG_MEM_OWN) {
      destroy(self);
    }
    return capture(other);
  }
};

template<class T>
struct AssignmentPolicy<T, ASSIGNMENT_SMARTPTR> {
  static SwigClassWrapper destroy(SwigClassWrapper self) {
    return DestructorPolicy<T, ASSIGNMENT_SMARTPTR>::destroy(self);
  }
  static SwigClassWrapper alias(SwigClassWrapper other) {
    SwigClassWrapper self;
    self.cptr = new T(*static_cast<T*>(other.cptr));
    self.cmemflags = other.cmemflags | SWIG_MEM_OWN;
    return self;
  }
  static SwigClassWrapper move_alias(SwigClassWrapper self, SwigClassWrapper other) {
    self = copy_alias(self, other);
    self.cmemflags = other.cmemflags & ~SWIG_MEM_RVALUE;
    destroy(other);
    return self;
  }
  static SwigClassWrapper copy_alias(SwigClassWrapper self, SwigClassWrapper other) {
    // LHS and RHS should both 'own' their shared pointers
    T *pself = static_cast<T*>(self.cptr);
    T *pother = static_cast<T*>(other.cptr);
    *pself = *pother;
    return self;
  }
};

} // end namespace swig

template<class T, swig::AssignmentType A>
SWIGINTERN void SWIG_assign(SwigClassWrapper* self, SwigClassWrapper other) {
  typedef swig::AssignmentPolicy<T, A> Policy_t;

  if (self->cptr == NULL) {
    /* LHS is unassigned */
    if (other.cmemflags & SWIG_MEM_RVALUE) {
      /* Capture pointer from RHS, clear 'moving' flag */
      *self = swig::capture(other);
    } else {
      /* Aliasing another class; clear ownership or copy smart pointer */
      *self = Policy_t::alias(other);
    }
  } else if (other.cptr == NULL) {
    /* Replace LHS with a null pointer */
    *self = Policy_t::destroy(*self);
  } else if (self->cptr == other.cptr) {
    /* Self-assignment: ignore */
  } else if (other.cmemflags & SWIG_MEM_RVALUE) {
    /* Transferred ownership from a variable that's about to be lost.
     * Move-assign and delete the transient data */
    *self = Policy_t::move_alias(*self, other);
  } else {
    /* RHS shouldn't be deleted, alias to LHS */
    *self = Policy_t::copy_alias(*self, other);
  }
}

template<class T, swig::AssignmentType A>
SWIGINTERN void SWIG_free_rvalue(SwigClassWrapper other) {
  typedef swig::AssignmentPolicy<T, A> Policy_t;
  if (other.cmemflags & SWIG_MEM_RVALUE 
      && other.cmemflags & SWIG_MEM_OWN) {
    /* We own *and* are being passed an expiring value */
    Policy_t::destroy(other);
  }
}



#include <cctype>


#include <algorithm>


  SWIGINTERN bool flc_has_junk(const std::string& s, size_t pos) {
    return !std::all_of(s.begin() + pos, s.end(),
                        [](unsigned char c) -> bool { return std::isspace(c); });
  }

extern "C" {
SWIGEXPORT SwigClassWrapper _wrap_new_string__SWIG_0() {
  SwigClassWrapper fresult ;
  std::string *result = 0 ;
  
  result = (std::string *)new std::string();
  fresult.cptr = (void*)result;
  fresult.cmemflags = SWIG_MEM_RVALUE | (1 ? SWIG_MEM_OWN : 0);
  return fresult;
}


SWIGEXPORT SwigClassWrapper _wrap_new_string__SWIG_1(size_t const *farg1, char const *farg2) {
  SwigClassWrapper fresult ;
  std::string::size_type arg1 ;
  std::string::value_type arg2 ;
  std::string *result = 0 ;
  
  arg1 = (std::string::size_type)(*farg1);
  arg2 = (std::string::value_type)(*farg2);
  result = (std::string *)new std::string(arg1,arg2);
  fresult.cptr = (void*)result;
  fresult.cmemflags = SWIG_MEM_RVALUE | (1 ? SWIG_MEM_OWN : 0);
  return fresult;
}


SWIGEXPORT SwigClassWrapper _wrap_new_string__SWIG_2(SwigArrayWrapper *farg1) {
  SwigClassWrapper fresult ;
  std::string *arg1 = 0 ;
  std::string tempstr1 ;
  std::string *result = 0 ;
  
  tempstr1 = std::string(static_cast<char *>(farg1->data), farg1->size);
  arg1 = &tempstr1;
  result = (std::string *)new std::string((std::string const &)*arg1);
  fresult.cptr = (void*)result;
  fresult.cmemflags = SWIG_MEM_RVALUE | (1 ? SWIG_MEM_OWN : 0);
  return fresult;
}


SWIGEXPORT size_t _wrap_string_size(SwigClassWrapper *farg1) {
  size_t fresult ;
  std::string *arg1 = (std::string *) 0 ;
  std::string::size_type result;
  
  SWIG_check_nonnull(farg1->cptr, "std::string const *", "string", "std::string::size() const", return 0);
  arg1 = (std::string *)farg1->cptr;
  result = ((std::string const *)arg1)->size();
  fresult = (std::string::size_type)(result);
  return fresult;
}


SWIGEXPORT int _wrap_string_empty(SwigClassWrapper *farg1) {
  int fresult ;
  std::string *arg1 = (std::string *) 0 ;
  bool result;
  
  SWIG_check_nonnull(farg1->cptr, "std::string const *", "string", "std::string::empty() const", return 0);
  arg1 = (std::string *)farg1->cptr;
  result = (bool)((std::string const *)arg1)->empty();
  fresult = (result ? 1 : 0);
  return fresult;
}


SWIGEXPORT char _wrap_string_front(SwigClassWrapper *farg1) {
  char fresult ;
  std::string *arg1 = (std::string *) 0 ;
  char *result = 0 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string const *", "string", "std::string::front() const", return 0);
  arg1 = (std::string *)farg1->cptr;
  result = (char *) &((std::string const *)arg1)->front();
  fresult = *result;
  return fresult;
}


SWIGEXPORT char _wrap_string_back(SwigClassWrapper *farg1) {
  char fresult ;
  std::string *arg1 = (std::string *) 0 ;
  char *result = 0 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string const *", "string", "std::string::back() const", return 0);
  arg1 = (std::string *)farg1->cptr;
  result = (char *) &((std::string const *)arg1)->back();
  fresult = *result;
  return fresult;
}


SWIGEXPORT void _wrap_string_resize__SWIG_0(SwigClassWrapper *farg1, size_t const *farg2) {
  std::string *arg1 = (std::string *) 0 ;
  std::string::size_type arg2 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::resize(std::string::size_type)", return );
  arg1 = (std::string *)farg1->cptr;
  arg2 = (std::string::size_type)(*farg2);
  (arg1)->resize(arg2);
}


SWIGEXPORT void _wrap_string_resize__SWIG_1(SwigClassWrapper *farg1, size_t const *farg2, char const *farg3) {
  std::string *arg1 = (std::string *) 0 ;
  std::string::size_type arg2 ;
  std::string::value_type arg3 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::resize(std::string::size_type,std::string::value_type)", return );
  arg1 = (std::string *)farg1->cptr;
  arg2 = (std::string::size_type)(*farg2);
  arg3 = (std::string::value_type)(*farg3);
  (arg1)->resize(arg2,arg3);
}


SWIGEXPORT void _wrap_string_assign(SwigClassWrapper *farg1, SwigArrayWrapper *farg2) {
  std::string *arg1 = (std::string *) 0 ;
  std::string *arg2 = 0 ;
  std::string tempstr2 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::assign(std::string const &)", return );
  arg1 = (std::string *)farg1->cptr;
  tempstr2 = std::string(static_cast<char *>(farg2->data), farg2->size);
  arg2 = &tempstr2;
  (arg1)->assign((std::string const &)*arg2);
}


SWIGEXPORT void _wrap_string_push_back(SwigClassWrapper *farg1, char const *farg2) {
  std::string *arg1 = (std::string *) 0 ;
  std::string::value_type arg2 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::push_back(std::string::value_type)", return );
  arg1 = (std::string *)farg1->cptr;
  arg2 = (std::string::value_type)(*farg2);
  (arg1)->push_back(arg2);
}


SWIGEXPORT void _wrap_string_pop_back(SwigClassWrapper *farg1) {
  std::string *arg1 = (std::string *) 0 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::pop_back()", return );
  arg1 = (std::string *)farg1->cptr;
  (arg1)->pop_back();
}


SWIGEXPORT void _wrap_string_clear(SwigClassWrapper *farg1) {
  std::string *arg1 = (std::string *) 0 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::clear()", return );
  arg1 = (std::string *)farg1->cptr;
  (arg1)->clear();
}


SWIGEXPORT size_t _wrap_string_find__SWIG_0(SwigClassWrapper *farg1, SwigArrayWrapper *farg2, size_t const *farg3) {
  size_t fresult ;
  std::string *arg1 = (std::string *) 0 ;
  std::string *arg2 = 0 ;
  std::string::size_type arg3 ;
  std::string tempstr2 ;
  std::string::size_type result;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::find(std::string const &,std::string::size_type)", return 0);
  arg1 = (std::string *)farg1->cptr;
  tempstr2 = std::string(static_cast<char *>(farg2->data), farg2->size);
  arg2 = &tempstr2;
  arg3 = *farg3 - 1;
  result = (arg1)->find((std::string const &)*arg2,arg3);
  fresult = (result == std::string::npos ? 0 : result + 1);
  return fresult;
}


SWIGEXPORT size_t _wrap_string_find__SWIG_1(SwigClassWrapper *farg1, SwigArrayWrapper *farg2) {
  size_t fresult ;
  std::string *arg1 = (std::string *) 0 ;
  std::string *arg2 = 0 ;
  std::string tempstr2 ;
  std::string::size_type result;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::find(std::string const &)", return 0);
  arg1 = (std::string *)farg1->cptr;
  tempstr2 = std::string(static_cast<char *>(farg2->data), farg2->size);
  arg2 = &tempstr2;
  result = (arg1)->find((std::string const &)*arg2);
  fresult = (result == std::string::npos ? 0 : result + 1);
  return fresult;
}


SWIGEXPORT void _wrap_string_append(SwigClassWrapper *farg1, SwigArrayWrapper *farg2) {
  std::string *arg1 = (std::string *) 0 ;
  std::string *arg2 = 0 ;
  std::string tempstr2 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::append(std::string const &)", return );
  arg1 = (std::string *)farg1->cptr;
  tempstr2 = std::string(static_cast<char *>(farg2->data), farg2->size);
  arg2 = &tempstr2;
  (arg1)->append((std::string const &)*arg2);
}


SWIGEXPORT int _wrap_string_compare(SwigClassWrapper *farg1, SwigClassWrapper *farg2) {
  int fresult ;
  std::string *arg1 = (std::string *) 0 ;
  std::string *arg2 = 0 ;
  int result;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::compare(std::string const &)", return 0);
  arg1 = (std::string *)farg1->cptr;
  SWIG_check_nonnull(farg2->cptr, "std::string const &", "string", "std::string::compare(std::string const &)", return 0);
  arg2 = (std::string *)farg2->cptr;
  result = (int)(arg1)->compare((std::string const &)*arg2);
  fresult = (int)(result);
  return fresult;
}


SWIGEXPORT void _wrap_string_set(SwigClassWrapper *farg1, size_t const *farg2, char const *farg3) {
  std::string *arg1 = (std::string *) 0 ;
  std::string::size_type arg2 ;
  std::string::value_type arg3 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::set(std::string::size_type,std::string::value_type)", return );
  arg1 = (std::string *)farg1->cptr;
  arg2 = *farg2 - 1;
  arg3 = (std::string::value_type)(*farg3);
  std_string_set(arg1,SWIG_STD_MOVE(arg2),arg3);
}


SWIGEXPORT char _wrap_string_get(SwigClassWrapper *farg1, size_t const *farg2) {
  char fresult ;
  std::string *arg1 = (std::string *) 0 ;
  std::string::size_type arg2 ;
  std::string::value_type result;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::get(std::string::size_type)", return 0);
  arg1 = (std::string *)farg1->cptr;
  arg2 = *farg2 - 1;
  result = (std::string::value_type)std_string_get(arg1,SWIG_STD_MOVE(arg2));
  fresult = (std::string::value_type)(result);
  return fresult;
}


SWIGEXPORT SwigArrayWrapper _wrap_string_view(SwigClassWrapper *farg1) {
  SwigArrayWrapper fresult ;
  std::string *arg1 = (std::string *) 0 ;
  std::string *result = 0 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::view()", return SwigArrayWrapper_uninitialized());
  arg1 = (std::string *)farg1->cptr;
  result = (std::string *) &std_string_view(arg1);
  fresult.data = (result->empty() ? NULL : const_cast<char*>(result->data()));
  fresult.size = result->size();
  return fresult;
}


SWIGEXPORT SwigArrayWrapper _wrap_string_str(SwigClassWrapper *farg1) {
  SwigArrayWrapper fresult ;
  std::string *arg1 = (std::string *) 0 ;
  std::string *result = 0 ;
  
  SWIG_check_nonnull(farg1->cptr, "std::string *", "string", "std::string::str()", return SwigArrayWrapper_uninitialized());
  arg1 = (std::string *)farg1->cptr;
  result = (std::string *) &std_string_str(arg1);
  fresult.size = result->size();
  if (fresult.size > 0) {
    fresult.data = malloc(fresult.size);
    memcpy(fresult.data, result->c_str(), fresult.size);
  } else {
    fresult.data = NULL;
  }
  return fresult;
}


SWIGEXPORT void _wrap_delete_string(SwigClassWrapper *farg1) {
  std::string *arg1 = (std::string *) 0 ;
  
  arg1 = (std::string *)farg1->cptr;
  delete arg1;
}


SWIGEXPORT void _wrap_string_op_assign__(SwigClassWrapper *farg1, SwigClassWrapper *farg2) {
  std::string *arg1 = (std::string *) 0 ;
  std::string *arg2 = 0 ;
  
  (void)sizeof(arg1);
  (void)sizeof(arg2);
  SWIG_assign<std::string, SWIGPOLICY_std_string>(farg1, *farg2);
  
}


SWIGEXPORT int _wrap_stoi__SWIG_0(SwigArrayWrapper *farg1, int const *farg3) {
  int fresult ;
  std::string *arg1 = 0 ;
  size_t *arg2 = (size_t *) 0 ;
  int arg3 ;
  std::string tempstr1 ;
  size_t temp_pos2 ;
  int result;
  
  temp_pos2 = 0;
  arg2 = &temp_pos2;
  tempstr1 = std::string(static_cast<char *>(farg1->data), farg1->size);
  arg1 = &tempstr1;
  arg3 = (int)(*farg3);
  {
    SWIG_check_unhandled_exception_impl("std::stoi(std::string const &,size_t *,int)");;
    try {
      result = (int)std::stoi((std::string const &)*arg1,arg2,arg3);
    }
    catch (const std::invalid_argument& e) {
      SWIG_exception_impl("std::stoi(std::string const &,size_t *,int)", -9, e.what(), return 0);
    }
    catch (const std::out_of_range& e) {
      SWIG_exception_impl("std::stoi(std::string const &,size_t *,int)", -7, e.what(), return 0);
    }
  }
  fresult = (int)(result);
  if (flc_has_junk(*arg1, temp_pos2)) {
    SWIG_exception_impl("std::stoi(std::string const &,size_t *,int)", -9, "Junk at end of string", return 0);
  }
  return fresult;
}


SWIGEXPORT int _wrap_stoi__SWIG_1(SwigArrayWrapper *farg1) {
  int fresult ;
  std::string *arg1 = 0 ;
  size_t *arg2 = (size_t *) 0 ;
  std::string tempstr1 ;
  size_t temp_pos2 ;
  int result;
  
  temp_pos2 = 0;
  arg2 = &temp_pos2;
  tempstr1 = std::string(static_cast<char *>(farg1->data), farg1->size);
  arg1 = &tempstr1;
  {
    SWIG_check_unhandled_exception_impl("std::stoi(std::string const &,size_t *)");;
    try {
      result = (int)std::stoi((std::string const &)*arg1,arg2);
    }
    catch (const std::invalid_argument& e) {
      SWIG_exception_impl("std::stoi(std::string const &,size_t *)", -9, e.what(), return 0);
    }
    catch (const std::out_of_range& e) {
      SWIG_exception_impl("std::stoi(std::string const &,size_t *)", -7, e.what(), return 0);
    }
  }
  fresult = (int)(result);
  if (flc_has_junk(*arg1, temp_pos2)) {
    SWIG_exception_impl("std::stoi(std::string const &,size_t *)", -9, "Junk at end of string", return 0);
  }
  return fresult;
}


SWIGEXPORT long _wrap_stol__SWIG_0(SwigArrayWrapper *farg1, int const *farg3) {
  long fresult ;
  std::string *arg1 = 0 ;
  size_t *arg2 = (size_t *) 0 ;
  int arg3 ;
  std::string tempstr1 ;
  size_t temp_pos2 ;
  long result;
  
  temp_pos2 = 0;
  arg2 = &temp_pos2;
  tempstr1 = std::string(static_cast<char *>(farg1->data), farg1->size);
  arg1 = &tempstr1;
  arg3 = (int)(*farg3);
  {
    SWIG_check_unhandled_exception_impl("std::stol(std::string const &,size_t *,int)");;
    try {
      result = (long)std::stol((std::string const &)*arg1,arg2,arg3);
    }
    catch (const std::invalid_argument& e) {
      SWIG_exception_impl("std::stol(std::string const &,size_t *,int)", -9, e.what(), return 0);
    }
    catch (const std::out_of_range& e) {
      SWIG_exception_impl("std::stol(std::string const &,size_t *,int)", -7, e.what(), return 0);
    }
  }
  fresult = (long)(result);
  if (flc_has_junk(*arg1, temp_pos2)) {
    SWIG_exception_impl("std::stol(std::string const &,size_t *,int)", -9, "Junk at end of string", return 0);
  }
  return fresult;
}


SWIGEXPORT long _wrap_stol__SWIG_1(SwigArrayWrapper *farg1) {
  long fresult ;
  std::string *arg1 = 0 ;
  size_t *arg2 = (size_t *) 0 ;
  std::string tempstr1 ;
  size_t temp_pos2 ;
  long result;
  
  temp_pos2 = 0;
  arg2 = &temp_pos2;
  tempstr1 = std::string(static_cast<char *>(farg1->data), farg1->size);
  arg1 = &tempstr1;
  {
    SWIG_check_unhandled_exception_impl("std::stol(std::string const &,size_t *)");;
    try {
      result = (long)std::stol((std::string const &)*arg1,arg2);
    }
    catch (const std::invalid_argument& e) {
      SWIG_exception_impl("std::stol(std::string const &,size_t *)", -9, e.what(), return 0);
    }
    catch (const std::out_of_range& e) {
      SWIG_exception_impl("std::stol(std::string const &,size_t *)", -7, e.what(), return 0);
    }
  }
  fresult = (long)(result);
  if (flc_has_junk(*arg1, temp_pos2)) {
    SWIG_exception_impl("std::stol(std::string const &,size_t *)", -9, "Junk at end of string", return 0);
  }
  return fresult;
}


SWIGEXPORT long long _wrap_stoll__SWIG_0(SwigArrayWrapper *farg1, int const *farg3) {
  long long fresult ;
  std::string *arg1 = 0 ;
  size_t *arg2 = (size_t *) 0 ;
  int arg3 ;
  std::string tempstr1 ;
  size_t temp_pos2 ;
  long long result;
  
  temp_pos2 = 0;
  arg2 = &temp_pos2;
  tempstr1 = std::string(static_cast<char *>(farg1->data), farg1->size);
  arg1 = &tempstr1;
  arg3 = (int)(*farg3);
  {
    SWIG_check_unhandled_exception_impl("std::stoll(std::string const &,size_t *,int)");;
    try {
      result = (long long)std::stoll((std::string const &)*arg1,arg2,arg3);
    }
    catch (const std::invalid_argument& e) {
      SWIG_exception_impl("std::stoll(std::string const &,size_t *,int)", -9, e.what(), return 0);
    }
    catch (const std::out_of_range& e) {
      SWIG_exception_impl("std::stoll(std::string const &,size_t *,int)", -7, e.what(), return 0);
    }
  }
  fresult = (long long)(result);
  if (flc_has_junk(*arg1, temp_pos2)) {
    SWIG_exception_impl("std::stoll(std::string const &,size_t *,int)", -9, "Junk at end of string", return 0);
  }
  return fresult;
}


SWIGEXPORT long long _wrap_stoll__SWIG_1(SwigArrayWrapper *farg1) {
  long long fresult ;
  std::string *arg1 = 0 ;
  size_t *arg2 = (size_t *) 0 ;
  std::string tempstr1 ;
  size_t temp_pos2 ;
  long long result;
  
  temp_pos2 = 0;
  arg2 = &temp_pos2;
  tempstr1 = std::string(static_cast<char *>(farg1->data), farg1->size);
  arg1 = &tempstr1;
  {
    SWIG_check_unhandled_exception_impl("std::stoll(std::string const &,size_t *)");;
    try {
      result = (long long)std::stoll((std::string const &)*arg1,arg2);
    }
    catch (const std::invalid_argument& e) {
      SWIG_exception_impl("std::stoll(std::string const &,size_t *)", -9, e.what(), return 0);
    }
    catch (const std::out_of_range& e) {
      SWIG_exception_impl("std::stoll(std::string const &,size_t *)", -7, e.what(), return 0);
    }
  }
  fresult = (long long)(result);
  if (flc_has_junk(*arg1, temp_pos2)) {
    SWIG_exception_impl("std::stoll(std::string const &,size_t *)", -9, "Junk at end of string", return 0);
  }
  return fresult;
}


SWIGEXPORT float _wrap_stof(SwigArrayWrapper *farg1) {
  float fresult ;
  std::string *arg1 = 0 ;
  size_t *arg2 = (size_t *) 0 ;
  std::string tempstr1 ;
  size_t temp_pos2 ;
  float result;
  
  temp_pos2 = 0;
  arg2 = &temp_pos2;
  tempstr1 = std::string(static_cast<char *>(farg1->data), farg1->size);
  arg1 = &tempstr1;
  {
    SWIG_check_unhandled_exception_impl("std::stof(std::string const &,size_t *)");;
    try {
      result = (float)std::stof((std::string const &)*arg1,arg2);
    }
    catch (const std::invalid_argument& e) {
      SWIG_exception_impl("std::stof(std::string const &,size_t *)", -9, e.what(), return 0);
    }
    catch (const std::out_of_range& e) {
      SWIG_exception_impl("std::stof(std::string const &,size_t *)", -7, e.what(), return 0);
    }
  }
  fresult = (float)(result);
  if (flc_has_junk(*arg1, temp_pos2)) {
    SWIG_exception_impl("std::stof(std::string const &,size_t *)", -9, "Junk at end of string", return 0);
  }
  return fresult;
}


SWIGEXPORT double _wrap_stod(SwigArrayWrapper *farg1) {
  double fresult ;
  std::string *arg1 = 0 ;
  size_t *arg2 = (size_t *) 0 ;
  std::string tempstr1 ;
  size_t temp_pos2 ;
  double result;
  
  temp_pos2 = 0;
  arg2 = &temp_pos2;
  tempstr1 = std::string(static_cast<char *>(farg1->data), farg1->size);
  arg1 = &tempstr1;
  {
    SWIG_check_unhandled_exception_impl("std::stod(std::string const &,size_t *)");;
    try {
      result = (double)std::stod((std::string const &)*arg1,arg2);
    }
    catch (const std::invalid_argument& e) {
      SWIG_exception_impl("std::stod(std::string const &,size_t *)", -9, e.what(), return 0);
    }
    catch (const std::out_of_range& e) {
      SWIG_exception_impl("std::stod(std::string const &,size_t *)", -7, e.what(), return 0);
    }
  }
  fresult = (double)(result);
  if (flc_has_junk(*arg1, temp_pos2)) {
    SWIG_exception_impl("std::stod(std::string const &,size_t *)", -9, "Junk at end of string", return 0);
  }
  return fresult;
}


} // extern

