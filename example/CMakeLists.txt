#---------------------------------*-CMake-*-----------------------------------#
# Copyright (c) 2021 Oak Ridge National Laboratory, UT-Battelle, LLC.
# License-Filename: LICENSE
# SPDX-License-Identifier: MIT
#-----------------------------------------------------------------------------#

if(NOT DEFINED PROJECT_NAME)
  # Allow use for this script as an external installation
  cmake_minimum_required(VERSION 3.12)
  # Enable use as a standalone test
  project(FlibcppExample LANGUAGES Fortran)
  find_package(Flibcpp CONFIG REQUIRED)
endif()

# Create executable with dependencies
macro(flibcpp_example name)
  add_executable(${name}.exe ${name}.f90)
  target_link_libraries(${name}.exe example_utils_lib ${ARGN})
endmacro()

#---------------------------------------------------------------------------##
# TEST LIBRARIES
#---------------------------------------------------------------------------##

add_library(example_utils_lib
  "example_utils.f90"
)
target_link_libraries(example_utils_lib
  Flibcpp::flc Flibcpp::flc_string Flibcpp::flc_vector)

#---------------------------------------------------------------------------##
# EXAMPLES
#---------------------------------------------------------------------------##

flibcpp_example(sort
  Flibcpp::flc_algorithm Flibcpp::flc_random Flibcpp::flc_string)

flibcpp_example(vecstr
  Flibcpp::flc_string Flibcpp::flc_vector)

flibcpp_example(sort_generic
  Flibcpp::flc_algorithm)

#---------------------------------------------------------------------------##
# TESTS
#---------------------------------------------------------------------------##

if(BUILD_TESTING)
  add_test(
    NAME examples
    COMMAND "${CMAKE_CURRENT_SOURCE_DIR}/run-examples.sh"
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")
endif()
