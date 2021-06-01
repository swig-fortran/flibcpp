#---------------------------------------------------------------------------#
# \file doc/CMakeLists.txt
#
# Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
# Distributed under an MIT open source license: see LICENSE for details.
#---------------------------------------------------------------------------#

configure_file("version.json.in" "version.json" @ONLY)
add_custom_target(doc ALL)
add_custom_command(TARGET doc
  COMMAND "${CMAKE_COMMAND}" -E env
  "CMAKE_CURRENT_BINARY_DIR=${CMAKE_CURRENT_BINARY_DIR}"
  "${SPHINX_EXECUTABLE}" -q
    -d "${CMAKE_CURRENT_BINARY_DIR}/doctrees"
    -b html
    "${CMAKE_CURRENT_SOURCE_DIR}"
    "${CMAKE_CURRENT_BINARY_DIR}/html"
  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
  COMMENT "Building HTML documentation with Sphinx"
  BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/html/index.html"
)

# Note: latex generation creates a makefile that muts be run
add_custom_target(doc_latex)
add_custom_command(TARGET doc_latex
  COMMAND "${CMAKE_COMMAND}" -E env
  "CMAKE_CURRENT_BINARY_DIR=${CMAKE_CURRENT_BINARY_DIR}"
  "${SPHINX_EXECUTABLE}" -q
    -d "${CMAKE_CURRENT_BINARY_DIR}/doctrees"
    -b latex
    "${CMAKE_CURRENT_SOURCE_DIR}"
    "${CMAKE_CURRENT_BINARY_DIR}/latex"
  COMMENT "Building LaTeX documentation with Sphinx"
  BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/latex/Flibcpp.tex"
)
add_custom_target(doc_pdf)
add_custom_command(TARGET doc_pdf
  COMMAND "${CMAKE_COMMAND}" -E env
  "LATEXOPTS="
  latexmk -pdf flibcpp-tm-header Flibcpp
  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/latex"
  COMMENT "Building PDF documentation from LaTeX"
  BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/latex/Flibcpp.pdf"
)
add_dependencies(doc_pdf doc_latex)

install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/html/"
  DESTINATION "${CMAKE_INSTALL_DOCDIR}"
)

