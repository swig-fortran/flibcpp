include(UseSWIG)

set(SWIG_FORTRAN_EXTRA_FILE_EXTENSIONS ".f90")

# Check that SWIG has been found
if (NOT SWIG_EXECUTABLE)
  message(FATAL_ERROR "SWIG is not available.")
endif()

# Make sure it's the branch that actually supports Fortran
if (NOT SWIG_CHECKED_FORTRAN)
  execute_process(COMMAND ${SWIG_EXECUTABLE} -help
    OUTPUT_VARIABLE SWIG_help_output
    ERROR_VARIABLE SWIG_help_output
    RESULT_VARIABLE SWIG_help_result)
  if (NOT SWIG_help_output MATCHES "Fortran")
    message(FATAL_ERROR "This version of SWIG does not support Fortran "
      "wrapping. Please install the version from "
      "https://github.com/sethrj/swig")
  endif()
  set(SWIG_CHECKED_FORTRAN TRUE CACHE INTERNAL "")
endif()

