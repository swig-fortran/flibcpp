#---------------------------------------------------------------------------#
# \file CMakeLists.txt
#
# Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
# Distributed under an MIT open source license: see LICENSE for details.
#---------------------------------------------------------------------------#

cmake_minimum_required(VERSION 3.8)
project(Flibcpp VERSION 0.3.0 LANGUAGES CXX Fortran)

#---------------------------------------------------------------------------#
# OPTIONS
#---------------------------------------------------------------------------#

if (FLIBCPP_DEV OR FLIBCPP_BUILD_EXAMPLES OR FLIBCPP_BUILD_TESTS)
  set(_DEFAULT_BUILD_TESTING ON)
endif()

option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(BUILD_TESTING "Enable CTest" ${_DEFAULT_BUILD_TESTING})
option(FLIBCPP_DEV "Default to using development-centered options" OFF)
option(FLIBCPP_BUILD_DOCS "Build documentation with Sphinx" ${FLIBCPP_DEV})
option(FLIBCPP_BUILD_EXAMPLES "Build examples" ON)
option(FLIBCPP_BUILD_TESTS "Build Flibcpp tests" ${BUILD_TESTING})
option(FLIBCPP_USE_SWIG "Regenerate source files using SWIG" ${FLIBCPP_DEV})

#---------------------------------------------------------------------------#
# FLAGS
#---------------------------------------------------------------------------#

# Fortran standard
set(FLIBCPP_FORTRAN_STD "03" CACHE STRING
   "Fortran standard for compiling generated code (options: 03/08/15/18)")
if (FLIBCPP_FORTRAN_STD AND NOT FLIBCPP_FORTRAN_STD STREQUAL "none")
  if (CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
    set(_FLIBCPP_STD_FLAGS "-std=f20${FLIBCPP_FORTRAN_STD}")
  elseif (CMAKE_Fortran_COMPILER_ID STREQUAL "Intel")
    set(_FLIBCPP_STD_FLAGS "-std${FLIBCPP_FORTRAN_STD}")
  else()
    message(WARNING "Fortran standard flags are not known for "
      "compilier '${CMAKE_Fortran_COMPILER_ID}': ignoring"
      "FLIBCPP_FORTRAN_STD=${FLIBCPP_FORTRAN_STD}. Configure with "
      "the FFLAGS environment variable or explicitly specify "
      "CMAKE_Fortran_FLAGS")
    set(_FLIBCPP_STD_FLAGS "none" CACHE FORCE STRING "")
  endif()
endif()

# Build type
if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  if (FLIBCPP_DEV)
    set(_CMAKE_BUILD_TYPE "Debug")
  else ()
    set(_CMAKE_BUILD_TYPE "RelWithDebInfo")
  endif()
  message(STATUS "No build type selected, default to ${_CMAKE_BUILD_TYPE}")
  set(CMAKE_BUILD_TYPE "${_CMAKE_BUILD_TYPE}" CACHE STRING "Build type" FORCE)
endif()

#---------------------------------------------------------------------------#
# MODULES TO LOAD
#---------------------------------------------------------------------------#

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

if (FLIBCPP_USE_SWIG)
  find_package(SWIG)
endif()

if (FLIBCPP_USE_SWIG AND SWIG_FOUND)
  # SWIG is requested and available; make sure it's the Fortran fork.
  include(CheckSWIGFortran)
  if (CMAKE_VERSION VERSION_LESS 3.99)
    # TODO: This is until Fortran support gets added to the upstream cmake script
    include(UseSWIGFortran)
  else()
    cmake_policy(SET CMP0078 "NEW")
    cmake_policy(SET CMP0086 "NEW")
    include(UseSWIG)
  endif()
else()
  set(FLIBCPP_USE_SWIG FALSE)
endif()

# Enable testing based on BUILD_TESTING flag
include(CTest)

#---------------------------------------------------------------------------#
# VERSIONING
#---------------------------------------------------------------------------#

# Get a possible Git version generated using git-archive (see the .gitattributes
# file)
file(STRINGS "${CMAKE_CURRENT_SOURCE_DIR}/cmake/git-version.txt"
     FLIBCPP_VERSION_STRING)

if (NOT FLIBCPP_VERSION_STRING MATCHES "\\$Format:")
  # First line are decorators, second is hash
  list(GET FLIBCPP_VERSION_STRING 0 _tag)
  string(REGEX REPLACE "tag: *" "" _tag "${_tag}")
  list(GET FLIBCPP_VERSION_STRING 1 _hash)
  string(REGEX REPLACE " +" "" _hash "${_hash}")
  set(FLIBCPP_VERSION_STRING "${_tag}-g${_hash}")
else()
  find_package(Git)
  if (Git_FOUND)
    execute_process(
      COMMAND "${GIT_EXECUTABLE}" "describe"
      ERROR_QUIET
      WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
      OUTPUT_VARIABLE FLIBCPP_VERSION_STRING
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )
  else()
    set(FLIBCPP_VERSION_STRING "${Flibcpp_VERSION}")
  endif()
endif()

set(FLIBCPP_VERSION_CPP "${CMAKE_CURRENT_BINARY_DIR}/flibcpp_version.cpp")
configure_file("${CMAKE_CURRENT_SOURCE_DIR}/cmake/flibcpp_version.cpp.in"
  "${FLIBCPP_VERSION_CPP}" @ONLY)

#---------------------------------------------------------------------------#
# LIBRARY
#---------------------------------------------------------------------------#

include(GNUInstallDirs)

set(CMAKE_Fortran_MODULE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/module")
set(FLIBCPP_INTERFACE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")
set(FLIBCPP_GENERATE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(FLIBCPP_INSTALL_CONFIGDIR "${CMAKE_INSTALL_LIBDIR}/cmake/Flibcpp")
set(FLIBCPP_INSTALL_MODULEDIR "${CMAKE_INSTALL_INCLUDEDIR}")
set(FLIBCPP_NAMESPACE Flibcpp::)

# List of libraries exported by cmake/FlibcppConfig.cmake.in
set(FLIBCPP_LIBRARIES)

function(flibcpp_add_module name)
  if (FLIBCPP_USE_SWIG)
    # SWIG is available; actually generate the library dynamically.

    set(src_file "${FLIBCPP_INTERFACE_DIR}/${name}.i")
    # We're using C++
    set_property(SOURCE "${src_file}" PROPERTY CPLUSPLUS ON)
    # We need to include the source directory
    set_property(SOURCE "${src_file}" PROPERTY USE_TARGET_INCLUDE_DIRECTORIES ON)

    # Create the library
    swig_add_library(${name}
      LANGUAGE Fortran
      TYPE USE_BUILD_SHARED_LIBS
      OUTPUT_DIR "${FLIBCPP_GENERATE_DIR}"
      SOURCES "${src_file}" ${ARGN}
    )

    # Add SWIG headers
    target_include_directories(${name}
      PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
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
      "${FLIBCPP_GENERATE_DIR}/${name}.f90"
      "${FLIBCPP_GENERATE_DIR}/${name}FORTRAN_wrap.cxx"
      ${ARGN}
    )
  endif()

  # Allow the library to be referred to by its namespaced version, for use by
  # downstream projects that *directly* compile flibcpp
  add_library(${FLIBCPP_NAMESPACE}${name} ALIAS ${name})

  # Compile C++ code with C++11
  target_compile_features(${name}
    PRIVATE
      cxx_std_11
  )
  if (_FLIBCPP_STD_FLAGS)
    target_compile_options(${name}
      PUBLIC $<$<COMPILE_LANGUAGE:Fortran>:${_FLIBCPP_STD_FLAGS}>
    )
  endif()

  target_include_directories(${name}
    PUBLIC
      # Fortran modules
      $<BUILD_INTERFACE:${CMAKE_Fortran_MODULE_DIRECTORY}>
      $<INSTALL_INTERFACE:${FLIBCPP_INSTALL_MODULEDIR}>
  )

  # Set up installation
  install(TARGETS
    ${name}
    EXPORT Flibcpp-targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )
  # Add to list of targets to export
  set(FLIBCPP_LIBRARIES ${FLIBCPP_LIBRARIES} ${FLIBCPP_NAMESPACE}${name}
    PARENT_SCOPE
  )
endfunction()

# Install primary flc module, compiling version info as well
flibcpp_add_module(flc "${FLIBCPP_VERSION_CPP}")

# Also install 'import_flc' if using SWIG
if (FLIBCPP_USE_SWIG)
  install(FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/include/import_flc.i"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  )
endif()

flibcpp_add_module(flc_algorithm)
target_link_libraries(flc_algorithm flc_random flc)

flibcpp_add_module(flc_random)
target_link_libraries(flc_random flc)

flibcpp_add_module(flc_string)
target_link_libraries(flc_string flc)

flibcpp_add_module(flc_vector)
target_link_libraries(flc_vector flc flc_string)

#---------------------------------------------------------------------------#
# INSTALLATION
#---------------------------------------------------------------------------#

# Install module files
install(DIRECTORY
  "${CMAKE_Fortran_MODULE_DIRECTORY}/"
  DESTINATION "${FLIBCPP_INSTALL_MODULEDIR}"
)

install(EXPORT Flibcpp-targets
  FILE FlibcppTargets.cmake
  NAMESPACE ${FLIBCPP_NAMESPACE}
  DESTINATION ${FLIBCPP_INSTALL_CONFIGDIR}
)

# Create a ConfigVersion.cmake file
include(CMakePackageConfigHelpers)

configure_package_config_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/FlibcppConfig.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/FlibcppConfig.cmake"
  INSTALL_DESTINATION ${FLIBCPP_INSTALL_CONFIGDIR}
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/FlibcppConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/FlibcppConfig.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/FlibcppConfigVersion.cmake"
  DESTINATION ${FLIBCPP_INSTALL_CONFIGDIR}
)

#---------------------------------------------------------------------------#
# TESTING AND DOCS
#---------------------------------------------------------------------------#

if (FLIBCPP_BUILD_TESTS)
  add_subdirectory(test)
endif()

if (FLIBCPP_BUILD_EXAMPLES)
  add_subdirectory(example)
endif()

if (FLIBCPP_BUILD_DOCS)
  add_subdirectory(doc)
endif()

