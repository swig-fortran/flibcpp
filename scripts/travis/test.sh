#!/bin/sh -e
###############################################################################
# File  : scripts/travis/test.sh
###############################################################################

cd ${BUILD_ROOT}

ctest --output-on-failure
if [ "${FLIBCPP_DEV}" = "ON" ]; then
  ctest -E examples -D ExperimentalMemCheck --output-on-failure
fi

###############################################################################
# end of scripts/travis/test.sh
###############################################################################
