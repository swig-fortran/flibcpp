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



#define SWIG_VERSION 0x040101
#define SWIGFORTRAN

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



extern "C" {

int flc_ierr = 0;

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


#include <string.h>


// Stored exception message
SWIGINTERN const char* swig_last_exception_cstr = NULL;
// Retrieve error message
SWIGEXPORT const char* flc_get_serr() {
  if (!swig_last_exception_cstr) {
    SWIG_store_exception("UNKNOWN", SWIG_RuntimeError,
                         "no error string was present");
  }
  return swig_last_exception_cstr;
}


#include <string>


#include <cctype>

extern "C" {

// Call this function before any new action
SWIGEXPORT void SWIG_check_unhandled_exception_impl(const char* decl) {
  if (flc_ierr != 0) {
    // Construct message; calling the error string function ensures that
    // the string is allocated if the user did something goofy like
    // manually setting the integer. Since this function is not expected to
    // be wrapped by a catch statement, it will probably terminate the
    // program.
    std::string msg("An unhandled exception occurred before a call to ");
    msg += decl;
    msg += "; ";
    std::string prev_msg = flc_get_serr();
    prev_msg[0] = std::tolower(prev_msg[0]);
    msg += prev_msg;
    throw std::runtime_error(msg);
  }
}

// Save an exception to the fortran error code and string
SWIGEXPORT void SWIG_store_exception(const char *decl,
                                     int errcode,
                                     const char *msg) {
  ::flc_ierr = errcode;

  static std::string last_exception_msg;
  // Save the message to a std::string first
  last_exception_msg = "In ";
  last_exception_msg += decl;
  last_exception_msg += ": ";
  last_exception_msg += msg;
  swig_last_exception_cstr = last_exception_msg.c_str();
}
}


#include <typeinfo>
#include <stdexcept>


#include <stdint.h>


extern "C" {
extern const char flibcpp_version[];
extern const int flibcpp_version_major;
extern const int flibcpp_version_minor;
extern const int flibcpp_version_patch;
}

extern "C" {
SWIGEXPORT SwigArrayWrapper _wrap_get_serr() {
  SwigArrayWrapper fresult ;
  char *result = 0 ;
  
  result = (char *)flc_get_serr();
  fresult.size = strlen((char*)(result));
  fresult.data = const_cast< char * >(result);
  return fresult;
}


SWIGEXPORT SwigArrayWrapper _wrap_flibcpp_version_get() {
  SwigArrayWrapper fresult ;
  char *result = 0 ;
  
  result = (char *)(char *)flibcpp_version;
  fresult.size = strlen((char*)(result));
  fresult.data = const_cast< char * >(result);
  return fresult;
}


} // extern

