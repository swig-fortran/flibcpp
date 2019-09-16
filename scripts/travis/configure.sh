#!/bin/sh
###############################################################################
# File  : scripts/travis/configure.sh
###############################################################################

if [ "${GENERATOR}" = "ninja" ]; then
  CMAKE_GENERATOR="Ninja"
elif [ "${GENERATOR}" = "make" ]; then
  CMAKE_GENERATOR="Unix Makefiles"
else
  echo "Invalid generator '${GENERATOR}'"
  exit 1
fi

CXX_FLAGS="-Wall -Wextra -Werror"
Fortran_FLAGS="-Wall -Wextra -Wimplicit-procedure -Wimplicit-interface -Wno-compare-reals -Wno-maybe-uninitialized"

set -x
cd ${BUILD_ROOT} && cmake -G "${CMAKE_GENERATOR}" \
  -D FLIBCPP_DEV=${FLIBCPP_DEV} \
  -D FLIBCPP_BUILD_EXAMPLES=ON \
  -D FLIBCPP_BUILD_TESTS=ON \
  -D FLIBCPP_FORTRAN_STD="${FLIBCPP_FORTRAN_STD}" \
  -D CMAKE_CXX_FLAGS="${CXX_FLAGS}" \
  -D CMAKE_Fortran_FLAGS="${Fortran_FLAGS}" \
  -D CMAKE_INSTALL_PREFIX="${INSTALL_ROOT}" \
  ${SOURCE_ROOT}

###############################################################################
# end of scripts/travis/configure.sh
###############################################################################
