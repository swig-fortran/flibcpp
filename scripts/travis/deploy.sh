#!/bin/sh -e
###############################################################################
# File  : scripts/travis/deploy.sh
###############################################################################

if [ $(uname -s) = "Darwin" ]; then
  SO_EXT=.dylib
else
  SO_EXT=.so
fi

set -x
cd ${BUILD_ROOT} && ${GENERATOR} install

# Test existence of install files
test_f() {
  if ! [ -f "$1" ]; then
    echo -e "\e[0;31mMissing file $1\e[0m"
    ls -al "$(dirname "$1")"
    return 1
  fi
}

if [ "${FLIBCPP_DEV}" = "ON" ]; then
  test_f ${INSTALL_ROOT}/share/doc/Flibcpp/index.html
  test_f ${INSTALL_ROOT}/include/flc.i
fi

test_f ${INSTALL_ROOT}/include/flc.mod
test_f ${INSTALL_ROOT}/lib/libflc${SO_EXT}
test_f ${INSTALL_ROOT}/lib/cmake/Flibcpp/FlibcppConfig.cmake

# Test external installation
cd ${SOURCE_ROOT}/example
mkdir build
cd build
CMAKE_PREFIX_PATH=${INSTALL_ROOT} ${CMAKE} ..
make
../run-examples.sh

###############################################################################
# end of scripts/travis/deploy.sh
###############################################################################
