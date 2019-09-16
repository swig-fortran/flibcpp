#!/bin/bash -e
###############################################################################
# File  : example/before_install.sh
###############################################################################

export SOURCE_ROOT=${PWD}
export BUILD_ROOT=${SOURCE_ROOT}/build
export INSTALL_ROOT=${HOME}/install
export CMAKE_PREFIX_PATH=${INSTALL_ROOT}:${CMAKE_PREFIX_PATH}
export PATH=${INSTALL_ROOT}/bin:${PATH}
export FC=${FC:-gfortran}

mkdir -p ${BUILD_ROOT}

# Define a command (using built-in travis functions) to launch one of our
# scripts
function run_script {
  set +x
  set -e
  fold_start $1 "$2"
  local scriptloc="${SOURCE_ROOT}/scripts/travis/$1.sh"
  echo "Running ${scriptloc}"
  ${scriptloc}
  local result=$?
  fold_end $1
  return $?
}

###############################################################################
# UTILITIES FROM TRAVIS
#
# from https://github.com/travis-ci/travis-rubies/blob/build/build.sh
###############################################################################

function fold_start() {
  echo -e "travis_fold:start:$1\033[33;1m$2\033[0m"
}

function fold_end() {
  echo -e "\ntravis_fold:end:$1\r"
}

###############################################################################
# end of example/before_install.sh
###############################################################################
