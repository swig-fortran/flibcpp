#---------------------------------------------------------------------------#
# \file doc/CMakeLists.txt
#
# Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
# Distributed under an MIT open source license: see LICENSE for details.
#---------------------------------------------------------------------------#

configure_file("version.json.in" "version.json" @ONLY)

function(flibcpp_build_sphinx type output)
  add_custom_command(OUTPUT "${output}"
    VERBATIM COMMAND
      "${CMAKE_COMMAND}" -E env
        "PYTHONPATH=${FLIBCPP_PYTHONPATH}"
        "CMAKE_CURRENT_BINARY_DIR=${CMAKE_CURRENT_BINARY_DIR}"
      "${SPHINX_EXECUTABLE}" -q
        -d "${CMAKE_CURRENT_BINARY_DIR}/doctrees"
        -b ${type}
        "${CMAKE_CURRENT_SOURCE_DIR}"
        "${CMAKE_CURRENT_BINARY_DIR}/${type}"
    COMMENT "Building ${type} documentation with Sphinx"
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/conf.py"
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    ${ARGN}
  )
endfunction()

set(_doc_html "${CMAKE_CURRENT_BINARY_DIR}/html/index.html")
flibcpp_build_sphinx(html "${_doc_html}")
add_custom_target(doc ALL DEPENDS "${_doc_html}")

install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/html/"
  DESTINATION "${CMAKE_INSTALL_DOCDIR}"
)

# Note: latex generation creates a makefile that must be run
set(_doc_tex "${CMAKE_CURRENT_BINARY_DIR}/latex/Flibcpp.tex")
flibcpp_build_sphinx(latex "${_doc_tex}")

find_program(LATEXMK_EXECUTABLE latexmk)
if(NOT LATEXMK_EXECUTABLE)
  # Local variable to give helpful error at runtime?
  set(LATEXMK_EXECUTABLE latexmk)
endif()

# Download ornltm class
set(_ornltm_base "${CMAKE_CURRENT_BINARY_DIR}/latex/ornltm")
ExternalProject_Add(ornltm
  GIT_REPOSITORY https://code.ornl.gov/s3j/ornltm.git
  GIT_TAG 2ad59291117b487666d15d10a105de0d680e72a6
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  SOURCE_DIR "${_ornltm_base}"
)

set(_texenv "LATEXOPTS=" "TEXINPUTS=${_ornltm_base}/ornltm:")
function(flibcpp_build_latex input output)
  add_custom_command(OUTPUT "${output}"
    VERBATIM COMMAND
    "${CMAKE_COMMAND}" -E env ${_texenv}
      "${LATEXMK_EXECUTABLE}" -pdf "${input}"
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/latex"
    ${ARGN}
  )
endfunction()

# Generate header
set(_header_pdf "${CMAKE_CURRENT_BINARY_DIR}/latex/flibcpp-tm-header.pdf")
flibcpp_build_latex(
  "${CMAKE_CURRENT_SOURCE_DIR}/_static/flibcpp-tm-header.tex"
  "${_header_pdf}"
  COMMENT "Building tech memo header"
  DEPENDS ornltm
)

# Generate header
set(_footer_pdf "${CMAKE_CURRENT_BINARY_DIR}/latex/flibcpp-tm-footer.pdf")
flibcpp_build_latex(
  "${CMAKE_CURRENT_SOURCE_DIR}/_static/flibcpp-tm-footer.tex"
  "${_footer_pdf}"
  COMMENT "Building tech memo footer"
  DEPENDS ornltm
)

# Generate PDF
set(_doc_pdf "${CMAKE_CURRENT_BINARY_DIR}/latex/Flibcpp.pdf")
flibcpp_build_latex(
  Flibcpp
  "${_doc_pdf}"
  COMMENT "Building PDF documentation from LaTeX"
  DEPENDS "${_doc_tex}" "${_header_pdf}" "${_footer_pdf}" ornltm
)

add_custom_target(doc_pdf DEPENDS "${_doc_pdf}")
