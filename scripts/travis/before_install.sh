#!/bin/bash -e
###############################################################################
# File  : example/before_install.sh
###############################################################################

###############################################################################
# APT PACKAGE INSTALLS
#
# see https://docs.travis-ci.com/user/installing-dependencies
###############################################################################

set -x

if [ "${GCC_VERSION}" = "9" ]; then
  # Special repo needed for new GCC version
  sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
  sudo apt-get update -q
fi

if [ -n "${GCC_VERSION}" ]; then
  # Suffix for compilers and packages
  _GCCV="-${GCC_VERSION}"
fi

sudo apt-get install gfortran${_GCCV} -y

if [ -n "${GCC_VERSION}" ]; then
  sudo apt-get install gcc${_GCCV} -y
  sudo apt-get install g++${_GCCV} -y
fi

set +x

###############################################################################
# ENVIRONMENT VARIABLES
###############################################################################

export SOURCE_ROOT=${PWD}
export BUILD_ROOT=${SOURCE_ROOT}/build
export INSTALL_ROOT=${HOME}/install
export CMAKE_PREFIX_PATH=${INSTALL_ROOT}:${CMAKE_PREFIX_PATH}
export PATH=${INSTALL_ROOT}/bin:${PATH}
export FC=${FC:-gfortran${_GCCV}}
export CC=${CC:-gcc${_GCCV}}
export CXX=${CXX:-g++${_GCCV}}

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
