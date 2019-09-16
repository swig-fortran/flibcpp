#!/bin/sh
###############################################################################
# File  : scripts/travis/script.sh
#
# Build and test. 
###############################################################################

set -e

CXX_FLAGS="-Wall -Wextra -Werror"
Fortran_FLAGS="-Wall -Wextra -Wimplicit-procedure -Wimplicit-interface -Wno-compare-reals -Wno-maybe-uninitialized"

if [ "${GENERATOR}" = "ninja" ]; then
  CMAKE_GENERATOR="Ninja"
elif [ "${GENERATOR}" = "makefile" ]; then
  CMAKE_GENERATOR="Unix Makefiles"
else
  echo "Invalid generator '${GENERATOR}'"
  exit 1
fi

mkdir build && cd build
cmake -G "${CMAKE_GENERATOR}" \
  -D FLIBCPP_DEV=${FLIBCPP_DEV} \
  -D FLIBCPP_ENABLE_EXAMPLES=ON \
  -D FLIBCPP_ENABLE_TESTS=ON \
  -D FLIBCPP_FORTRAN_STD="${FLIBCPP_FORTRAN_STD}" \
  -D CMAKE_CXX_FLAGS="${CXX_FLAGS}" \
  -D CMAKE_Fortran_FLAGS="${Fortran_FLAGS}" \
  ..

${GENERATOR}
ctest
${GENERATOR} install

###############################################################################
# end of scripts/travis/script.sh
###############################################################################
