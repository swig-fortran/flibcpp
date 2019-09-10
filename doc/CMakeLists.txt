#---------------------------------------------------------------------------#
# \file doc/CMakeLists.txt
#
# Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
# Distributed under an MIT open source license: see LICENSE for details.
#---------------------------------------------------------------------------#

find_package(Sphinx REQUIRED)

add_custom_target(doc ALL)
add_custom_command(TARGET doc
  COMMAND "${SPHINX_EXECUTABLE}" -q
    -d "${CMAKE_CURRENT_BINARY_DIR}/doctrees"
    -b html
    "${CMAKE_CURRENT_SOURCE_DIR}"
    "${CMAKE_CURRENT_BINARY_DIR}/html"
  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
  COMMENT "Building HTML documentation with Sphinx"
  BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/html/index.html"
  )

install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/html/"
  DESTINATION "${CMAKE_INSTALL_DOCDIR}"
  )
