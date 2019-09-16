#!/bin/sh -ex
###############################################################################
# File  : scripts/travis/script.sh
#
# Build and test. 
###############################################################################

if [ "${FLIBCPP_DEV}" == "ON" ]; then
  echo "SWIG version: $(swig -version | grep SWIG)"
fi

CXX_FLAGS="-Wall -Wextra -Werror"
Fortran_FLAGS="-Wall -Wextra -Wimplicit-procedure -Wimplicit-interface -Wno-compare-reals -Wno-maybe-uninitialized"

mkdir build && cd build
cmake -G ${CMAKE_GENERATOR} \
  -D FLIBCPP_DEV=${FLIBCPP_DEV} \
  -D FLIBCPP_ENABLE_EXAMPLES=ON \
  -D FLIBCPP_ENABLE_TESTS=ON \
  -D FLIBCPP_FORTRAN_STD="${FLIBCPP_FORTRAN_STD}" \
  -D CMAKE_CXX_FLAGS="${CXX_FLAGS}" \
  -D CMAKE_Fortran_FLAGS="${Fortran_FLAGS}" \
  ..

_MAKE_CMD=
if [ "${CMAKE_GENERATOR}" == "Ninja" ]; then
  _MAKE_CMD=ninja
elif [ "${CMAKE_GENERATOR}" == "Makefile" ]; then
  _MAKE_CMD=make
else
  echo "Invalid generator '${CMAKE_GENERATOR}'"
  exit 1
fi

${_MAKE_CMD}
ctest
${_MAKE_CMD} install

###############################################################################
# end of scripts/travis/script.sh
###############################################################################
