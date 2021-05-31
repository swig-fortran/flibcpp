#!/bin/bash -e
###############################################################################
# File  : example/before_install.sh
###############################################################################

###############################################################################
# ENVIRONMENT VARIABLES
###############################################################################

export SOURCE_ROOT=${PWD}
export BUILD_ROOT=${SOURCE_ROOT}/build
export INSTALL_ROOT=${HOME}/install
export CMAKE_PREFIX_PATH=${INSTALL_ROOT}:${CMAKE_PREFIX_PATH}
export PATH=${INSTALL_ROOT}/bin:${PATH}
export FC=${FC:-gfortran}
export CC=${CC:-gcc}
export CXX=${CXX:-g++}
export CMAKE=/usr/bin/cmake # precompiled Travis overrides Focal apt
export CTEST=/usr/bin/ctest # precompiled Travis overrides Focal apt

mkdir -p ${BUILD_ROOT}

# Define a command (using built-in travis functions) to launch one of our
# scripts
run_script() {
  set +exv
  fold_start $1 "$2"
  local scriptloc="${SOURCE_ROOT}/scripts/travis/$1.sh"
  echo -e "\e[0;32mRunning ${scriptloc}\e[0m"
  ${scriptloc}
  local _RESULT=$?
  fold_end $1
  if [ ${_RESULT} -ne 0 ]; then
    echo -e "\e[1;31m${scriptloc} exited with ${_RESULT}\e[0m"
  fi
  return ${_RESULT}
}

###############################################################################
# UTILITIES FROM TRAVIS
#
# from https://github.com/travis-ci/travis-rubies/blob/build/build.sh
###############################################################################

fold_start() {
  echo -e "travis_fold:start:$1\033[33;1m$2\033[0m"
}

fold_end() {
  echo -e "\ntravis_fold:end:$1\r"
}

###############################################################################
# end of example/before_install.sh
###############################################################################
