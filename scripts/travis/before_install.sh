#!/bin/sh -ex
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
run_script() {
  fold_start $1 "$2"
  announce ${SOURCE_ROOT}/scripts/travis/$1.sh
  fold_end $1
}

###############################################################################
# end of example/before_install.sh
###############################################################################
