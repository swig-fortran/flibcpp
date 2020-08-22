#!/bin/sh -ex
SOURCE=$(cd $(dirname "${BASH_SOURCE[0]}")/../.. && pwd)
BUILD=${SOURCE}/build
PREFIX=${SOURCE}/install

test -d "${BUILD}" || mkdir -p "${BUILD}"
cd ${BUILD}

CMAKE=cmake
${CMAKE} --version

${CMAKE} \
  -G Ninja \
  -D FLIBCPP_DEV=ON \
  -D SWIG_EXECUTABLE="/rnsdhpc/code/_build/swig-debug/swig"  \
  -D SWIG_DIR="/rnsdhpc/code/swig/Lib" \
  -D BUILD_SHARED_LIBS=ON \
  -D CMAKE_Fortran_FLAGS="-Wall -Wextra -Wimplicit-procedure -Wimplicit-interface -Wno-compare-reals" \
  -D CMAKE_CXX_FLAGS="-Wall -Wextra -pedantic" \
  -D CMAKE_INSTALL_PREFIX="${PREFIX}" \
  ${SOURCE}
ninja -v
ctest --output-on-failure
ninja install
