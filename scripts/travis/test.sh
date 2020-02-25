#!/bin/sh -ex
###############################################################################
# File  : scripts/travis/test.sh
###############################################################################

cd ${BUILD_ROOT}

ctest --output-on-failure
if [ "${FLIBCPP_DEV}" = "ON" ]; then
  # Run tests (not examples, which use a shell script) through valgrind
  if ! ctest -E examples -D ExperimentalMemCheck --output-on-failure; then
    find Testing/Temporary -name "MemoryChecker.*.log" -exec cat {} +
    exit 1
  fi
fi

###############################################################################
# end of scripts/travis/test.sh
###############################################################################
