#---------------------------------------------------------------------------##
# \file flibcpp/test/CMakeLists.txt
#
# Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
# Distributed under an MIT open source license: see LICENSE for details.
#---------------------------------------------------------------------------##

# Create test with dependencies
macro(swig_fortran_add_test TESTNAME)
  add_executable(${TESTNAME}.exe ${TESTNAME}.F90)
  target_link_libraries(${TESTNAME}.exe ${ARGN})
  add_test(NAME ${TESTNAME} COMMAND ${TESTNAME}.exe)
endmacro()

swig_fortran_add_test(test_algorithm
  flc_algorithm)
swig_fortran_add_test(test_random
  flc_random)
swig_fortran_add_test(test_string
  flc_string)
swig_fortran_add_test(test_vector
  flc_vector)
