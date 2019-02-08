#---------------------------------------------------------------------------#
# \file doc/CMakeLists.txt
#
# Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
# Distributed under an MIT open source license: see LICENSE for details.
#---------------------------------------------------------------------------#

find_package(Sphinx REQUIRED)

add_custom_target(doc ALL)

if (SPHINX_OUTPUT_HTML)
  add_custom_command(TARGET doc
    COMMAND ${SPHINX_EXECUTABLE} -q -b html
      "${CMAKE_CURRENT_SOURCE_DIR}"
      "${CMAKE_CURRENT_BINARY_DIR}/html"
    COMMENT "Building HTML documentation with Sphinx"
    BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/html"
    )

  install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/html"
    DESTINATION "${DOCDIR}"
    )
endif()

if (SPHINX_OUTPUT_MAN)
  add_custom_command(TARGET doc
    COMMAND ${SPHINX_EXECUTABLE} -q -b man
      "${CMAKE_CURRENT_SOURCE_DIR}"
      "${CMAKE_CURRENT_BINARY_DIR}/man"
    COMMENT "Building manpage documentation with Sphinx"
    BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/man"
    )

  install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/man"
    DESTINATION "${MANDIR}"
    )
endif()
