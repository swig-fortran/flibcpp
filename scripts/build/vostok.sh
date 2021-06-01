#!/bin/sh -ex
SOURCE=$(cd $(dirname "${BASH_SOURCE[0]}")/../.. && pwd)
BUILD=${SOURCE}/build
PREFIX=${SOURCE}/install

test -d "${BUILD}" || mkdir -p "${BUILD}"
cd ${BUILD}

CMAKE=cmake
${CMAKE} --version

# NOTE: gcc 10.2 incorrectly warns about logical conversions, see
# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96319
module load swig/4.0.2-fortran gcc/11

${CMAKE} \
  -G Ninja \
  -D FLIBCPP_DEV=ON \
  -D FLIBCPP_Fortran_STANDARD=03 \
  -D BUILD_SHARED_LIBS=ON \
  -D CMAKE_Fortran_FLAGS="-Wall -Wextra -pedantic -Wimplicit-procedure -Wimplicit-interface -Wno-compare-reals" \
  -D CMAKE_CXX_FLAGS="-Wall -Wextra -pedantic -Werror" \
  -D CMAKE_INSTALL_PREFIX="${PREFIX}" \
  ${SOURCE}
ninja -v
ctest --output-on-failure
ninja install
