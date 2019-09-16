#!/bin/sh -ex
###############################################################################
# File  : scripts/travis/deploy.sh
###############################################################################

set -e
cd ${BUILD_ROOT}
${GENERATOR} install

# Test existence of install files

if [ "${FLIBCPP_DEV}" = "ON" ]; then
  test -f ${INSTALL_ROOT}/share/doc/Flibcpp/index.html
  test -f ${INSTALL_ROOT}/include/flc.i
fi

test -f ${INSTALL_ROOT}/include/flc.mod
test -f ${INSTALL_ROOT}/lib/libflc.dylib
test -f ${INSTALL_ROOT}/lib/cmake/Flibcpp/FlibcppConfig.cmake

###############################################################################
# end of scripts/travis/deploy.sh
###############################################################################
