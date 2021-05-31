#----------------------------------*-CMake-*----------------------------------#
# Copyright (c) 2021 Oak Ridge National Laboratory, UT-Battelle, LLC.
# License-Filename: LICENSE
# SPDX-License-Identifier: MIT
#[=======================================================================[.rst:

FlibUtils
---------

Utility functions for generating SWIG Fortran through CMake. These are designed
for simple projects with SWIG ``.i`` files in a top-level ``include`` directory
that generate SWIG source code into a top-level ``src`` directory.

.. command:: flib_warn_undefined

  Print a "package author" warning if the variable is defined: allowing the
  build to potentially complete but making clear where the first expectation
  failed.

.. command:: flib_fortran_standard

  Define a cache variable ${prefix}_Fortran_STANDARD that adds Fortran compiler
  flags as a directory-level property to enforce a compiler standard. (Only for
  GCC/Intel.) This should generally be used at a project-level scope.

    flib_fortran_standard(<prefix>)

.. command:: flib_find_and_use_swig

  If variable <prefix>_USE_SWIG is true, find a Fortran-compatible verison
  of SWIG, and include the UseSWIG file. This is a macro, so the find/use
  variables will propagate into the caller.

    flib_find_and_use_swig(<prefix>)

  This should be called at the top level of the project so that all
  subdirectories can access the FindSWIG variables. The macro affords
  backward compatibility through CMake 3.12.

.. command:: flib_dir_variables

  Define CMAKE_Fortran_MODULE_DIRECTORY and other internal variables (starting
  with <prefix>) needed for ``flib_add_fortran_module``.

.. command:: flib_add_fortran_module

  Create a SWIG+Fortran module and write to the interface/generate directories,
  or use precompiled source if ``<prefix>_USE_SWIG`` is false.

    flib_add_fortran_module(<prefix> <name> <cext> <fext> [source [...]])

  ``<prefix>``
    Same as the other prefix variables.

  ``<name>``
    SWIG module name, expected to be at ``${<prefix>_INTERFACE_DIR}/${name}.i``.
    This will also be the name of the target that's created.

  ``<cext>``
    Extension of the C/C++ file being created. If not ``c``, the ``CPLUSPLUS``
    property is set to true enabling the SWIG ``-cpp`` option.

  ``<fext>``
    Extension of the Fortran file to create. This should generally be ``f90``
    (no C preprocesssing) or ``F90`` (with preprocessing).

  source...
    Additional source files to compile into the target.

#]=======================================================================]

macro(flib_warn_undefined var)
  if(NOT DEFINED ${var})
    message(AUTHOR_WARNING "Expected ${var} to be defined")
  endif()
endmacro()

#-----------------------------------------------------------------------------#

function(flib_fortran_standard prefix)
  if(ARGC GREATER 1)
    set(default "${ARGV1}")
  else()
    set(default "none")
  endif()
  set(${prefix}_Fortran_STANDARD "${default}" CACHE STRING
     "Fortran standard for compiling generated code")
  set_property(CACHE ${prefix}_Fortran_STANDARD PROPERTY
    STRINGS "03" "08" "15" "18" "none")

  if(NOT ${prefix}_Fortran_STANDARD STREQUAL "none")
    set(_flib_fprefix)
    if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
      set(_flib_fprefix "-std=f20")
    elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "Intel")
      set(_flib_fprefix "-std")
    else()
      message(WARNING "Fortran standard flags are not known for "
        "compilier '${CMAKE_Fortran_COMPILER_ID}': ignoring "
        "${prefix}_Fortran_STANDARD=${${prefix}_Fortran_STANDARD}. "
        "Configure with the FFLAGS environment variable "
        "or explicitly specify CMAKE_Fortran_FLAGS")
      set(${prefix}_Fortran_STANDARD "none" CACHE FORCE STRING
        "Disabled: unknown compiler")
    endif()

    if(_flib_fprefix)
      set(_flib_fflag "${_flib_fprefix}${${prefix}_Fortran_STANDARD}")
      add_compile_options("$<$<COMPILE_LANGUAGE:Fortran>:${_flib_fflag}>")
    endif()
  endif()
endfunction()

#-----------------------------------------------------------------------------#
# Note: this must appear at CMakeLists level, not macro level
if(CMAKE_VERSION VERSION_LESS 3.18)
  list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/backport-cmake-318")
endif()

macro(flib_find_and_use_swig prefix)
  flib_warn_undefined(${prefix}_USE_SWIG)

  if(${prefix}_USE_SWIG)
    if(NOT SWIG_fortran_FOUND)
      find_package(SWIG COMPONENTS fortran REQUIRED)
    endif()

    if(CMAKE_VERSION VERSION_LESS 3.12)
      message(FATAL_ERROR "CMake 3.12 or higher is required to regenerate "
        "Fortran bindings using SWIG. Set ${prefix}_USE_SWIG to OFF "
        "and reconfigure.")
    endif()

    if(CMAKE_VERSION GREATER_EQUAL 3.13)
      cmake_policy(SET CMP0078 "NEW")
    else()
      set(FlibUtils_CMP0078 "NEW")
    endif()
    if(CMAKE_VERSION GREATER_EQUAL 3.14)
      cmake_policy(SET CMP0086 "NEW")
    else()
      set(FlibUtils_CMP0086 "NEW")
    endif()
    include(UseSWIG)
  endif()
endmacro()

#-----------------------------------------------------------------------------#

macro(flib_dir_variables prefix)
  # You must include GNUInstallDirs prior to calling this macro
  flib_warn_undefined(CMAKE_INSTALL_INCLUDEDIR)

  set(CMAKE_Fortran_MODULE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/fortran")
  set(${prefix}_INTERFACE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")
  set(${prefix}_GENERATE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
  set(${prefix}_INSTALL_MODULEDIR "${CMAKE_INSTALL_INCLUDEDIR}")
endmacro()

#-----------------------------------------------------------------------------#

function(flib_add_fortran_module prefix name cext fext)
  # You must call flib_dir_variables before this function.
  flib_warn_undefined(${prefix}_USE_SWIG)
  flib_warn_undefined(${prefix}_GENERATE_DIR)

  if(${prefix}_USE_SWIG)
    set(src_file "${${prefix}_INTERFACE_DIR}/${name}.i")
    if(NOT cext STREQUAL "c")
      # C++ file
      set_property(SOURCE "${src_file}" PROPERTY
        CPLUSPLUS ON)
      if(NOT cext STREQUAL "cxx")
        set_property(SOURCE "${src_file}" PROPERTY APPEND
          SWIG_COMPILE_OPTIONS "-cppext;${cext}")
      endif()
    endif()
    if(NOT fext STREQUAL "f90")
      set_property(SOURCE "${src_file}" PROPERTY APPEND
        SWIG_COMPILE_OPTIONS "-fext;${fext}")
    endif()

    # We need to include the source directory
    set_property(SOURCE "${src_file}" PROPERTY
      USE_TARGET_INCLUDE_DIRECTORIES ON)

    # Create the library
    swig_add_library(${name}
      LANGUAGE Fortran
      TYPE USE_BUILD_SHARED_LIBS
      OUTPUT_DIR "${${prefix}_GENERATE_DIR}"
      SOURCES "${src_file}" ${ARGN}
    )

    # Add SWIG headers
    target_include_directories(${name}
      PUBLIC
        "$<BUILD_INTERFACE:${${prefix}_INTERFACE_DIR}>"
        "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
    )

    # Install the interface file for downstream libraries to use
    install(FILES
      "${src_file}"
      DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    )
  else()
    # SWIG is *not* being used: compile the code committed in the repository,
    # generated by the developer with SWIG.
    add_library(${name}
      "${${prefix}_GENERATE_DIR}/${name}.${fext}"
      "${${prefix}_GENERATE_DIR}/${name}FORTRAN_wrap.${cext}"
      ${ARGN}
    )
  endif()

  target_include_directories(${name}
    PUBLIC
      # Fortran modules
      $<BUILD_INTERFACE:${CMAKE_Fortran_MODULE_DIRECTORY}>
      $<INSTALL_INTERFACE:${${prefix}_INSTALL_MODULEDIR}>
  )
endfunction()
