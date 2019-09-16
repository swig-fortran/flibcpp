#!/bin/bash -ex
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

set +x

# Define a command (using built-in travis functions) to launch one of our
# scripts
function run_script {
  fold_start $1 "$2"
  announce ${SOURCE_ROOT}/scripts/travis/$1.sh
  fold_end $1
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

function announce() {
  travis_time_start
  echo \$ $@
  "$@"
  travis_time_finish
}

function travis_time_start() {
  travis_timer_id=$(printf %08x $(( RANDOM * RANDOM )))
  travis_start_time=$(travis_nanoseconds)
  echo -en "travis_time:start:$travis_timer_id\r${ANSI_CLEAR}"
}

function travis_time_finish() {
  local result=$?
  travis_end_time=$(travis_nanoseconds)
  local duration=$(($travis_end_time-$travis_start_time))
  echo -en "\ntravis_time:end:$travis_timer_id:start=$travis_start_time,finish=$travis_end_time,duration=$duration\r${ANSI_CLEAR}"
  return $result
}

if hash gdate > /dev/null 2>&1; then
  function travis_nanoseconds() {
    gdate -u "+%s%N"
  }
elif [[ "$(uname)" = Darwin ]]; then
  function travis_nanoseconds() {
    # fallback to second precision on darwin (does not support %N)
    date -u "+%s000000000"
  }
else
  function travis_nanoseconds() {
    date -u "+%s%N"
  }
fi

###############################################################################
# end of example/before_install.sh
###############################################################################
