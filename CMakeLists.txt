#---------------------------------*-CMake-*----------------------------------#
# Copyright (c) 2019-2021 Oak Ridge National Laboratory, UT-Battelle, LLC.
# License-Filename: LICENSE
# SPDX-License-Identifier: MIT
#---------------------------------------------------------------------------#

cmake_minimum_required(VERSION 3.8...3.31)

# Determine version number from git metadata
include("${CMAKE_CURRENT_LIST_DIR}/cmake/CgvFindVersion.cmake")
cgv_find_version(Flibcpp)

project(Flibcpp VERSION "${Flibcpp_VERSION}" LANGUAGES CXX Fortran)
cmake_policy(VERSION 3.8...3.31)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
include(FlibUtils)

#---------------------------------------------------------------------------#
# OPTIONS
#---------------------------------------------------------------------------#
option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(FLIBCPP_DEV "Default to using development-centered options" OFF)
option(FLIBCPP_BUILD_DOCS "Build documentation with Sphinx" ${FLIBCPP_DEV})
option(FLIBCPP_USE_SWIG "Regenerate source files using SWIG" ${FLIBCPP_DEV})

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  set(_DEFAULT_BUILD_EXAMPLES ON)
endif()
option(FLIBCPP_BUILD_EXAMPLES "Build examples" ${_DEFAULT_BUILD_EXAMPLES})

if(FLIBCPP_DEV)
  set(_DEFAULT_BUILD_TESTS ON)
endif()
option(FLIBCPP_BUILD_TESTS "Build Flibcpp tests" ${_DEFAULT_BUILD_TESTS})

#---------------------------------------------------------------------------#
# FLAGS
#---------------------------------------------------------------------------#

# Define FLIBCPP_Fortran_STANDARD and add as Fortran compile options
flib_fortran_standard(FLIBCPP "03")

# Build type
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  if(FLIBCPP_DEV)
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

# Load SWIG if FLIBCPP_USE_SWIG is true
flib_find_and_use_swig(FLIBCPP)

# Load CTest if applicable
if(FLIBCPP_BUILD_TESTS OR FLIBCPP_BUILD_EXAMPLES)
  include(CTest)
endif()

if(FLIBCPP_BUILD_DOCS)
  find_package(Sphinx REQUIRED)
  include(ExternalProject) # for pdf header
  set(FLIBCPP_PYTHONPATH "$ENV{PYTHONPATH}" CACHE STRING
    "Python path used for generating documentation"
  )
endif()

#---------------------------------------------------------------------------#
# LIBRARY
#---------------------------------------------------------------------------#

include(GNUInstallDirs)

set(FLIBCPP_NAMESPACE "Flibcpp::")
flib_dir_variables(FLIBCPP)

# List of libraries exported by cmake/FlibcppConfig.cmake.in
set(FLIBCPP_LIBRARIES)

function(flibcpp_add_module name)
  flib_add_fortran_module(FLIBCPP ${name} "cxx" "f90" ${ARGN})

  # Compile C++ code with C++11
  target_compile_features(${name}
    PRIVATE
      cxx_std_11
  )
  # Compile with e.g. std=c++11 instead of =gnu++11
  set_property(TARGET ${name} PROPERTY CXX_EXTENSIONS OFF)

  # Allow the library to be referred to by its namespaced version, for use by
  # downstream projects that *directly* compile flibcpp
  add_library(${FLIBCPP_NAMESPACE}${name} ALIAS ${name})
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

# Configure version information and generate primary flibcpp module
set(FLIBCPP_VERSION_CPP "${CMAKE_CURRENT_BINARY_DIR}/flibcpp_version.cpp")
configure_file("${CMAKE_CURRENT_LIST_DIR}/cmake/flibcpp_version.cpp.in"
  "${FLIBCPP_VERSION_CPP}" @ONLY)
flibcpp_add_module(flc "${FLIBCPP_VERSION_CPP}")

# Also install 'import_flc' if using SWIG
if(FLIBCPP_USE_SWIG)
  install(FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/include/import_flc.i"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  )
endif()

flibcpp_add_module(flc_algorithm)
target_link_libraries(flc_algorithm flc_random flc)

flibcpp_add_module(flc_map)
target_link_libraries(flc_map flc flc_string)

flibcpp_add_module(flc_random)
target_link_libraries(flc_random flc)

flibcpp_add_module(flc_set)
target_link_libraries(flc_set flc flc_string)

flibcpp_add_module(flc_string)
target_link_libraries(flc_string flc)

flibcpp_add_module(flc_vector)
target_link_libraries(flc_vector flc flc_string)

#---------------------------------------------------------------------------#
# INSTALLATION
#---------------------------------------------------------------------------#

set(FLIBCPP_INSTALL_CONFIGDIR
    "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")

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

if(FLIBCPP_BUILD_TESTS)
  add_subdirectory(test)
endif()

if(FLIBCPP_BUILD_EXAMPLES)
  add_subdirectory(example)
endif()

if(FLIBCPP_BUILD_DOCS)
  add_subdirectory(doc)
endif()

