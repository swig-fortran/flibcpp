#---------------------------------------------------------------------------##
# \file flibcpp/example/CMakeLists.txt
#
# Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
# Distributed under an MIT open source license: see LICENSE for details.
#---------------------------------------------------------------------------##

# Create executable with dependencies
macro(swig_fortran_add_example name)
  add_executable(${name}.exe ${name}.f90)
  target_link_libraries(${name}.exe ${ARGN})
endmacro()

swig_fortran_add_example(sort
  flc_algorithm)

##---------------------------------------------------------------------------##
## end of common/CMakeLists.txt
##---------------------------------------------------------------------------##
