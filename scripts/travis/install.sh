#!/bin/sh
###############################################################################
# File  : scripts/travis/install.sh
#
# Install dependencies. 
###############################################################################

export FC=$(hash gfortran)
echo "Fortran compiler: ${FC}"
if [ -n "${FC}" ]; then
  echo "Compiler version: $(${FC} | head -1)"
fi

INSTALL_ROOT=${PWD}/install
mkdir -p ${INSTALL_ROOT}/bin
export CMAKE_PREFIX_PATH=${INSTALL_ROOT}:${CMAKE_PREFIX_PATH}
export PATH=${INSTALL_ROOT}/bin:${PATH}

if [ "${FLIBCPP_DEV}" = "ON" ]; then
  # Install SWIG-fortran
  git clone --depth=1 https://github.com/swig-fortran/swig
  pushd swig 
  echo "SWIG git revision: $(git rev-parse HEAD)"
  ./autogen.sh
  ./configure --prefix="${INSTALL_ROOT}" --without-alllang --with-fortran=$FC
  make
  make install
  popd
  echo "Installed SWIG version: $(swig -version | grep SWIG)"
fi

if [ "${GENERATOR}" = "ninja" ]; then
  # Install Ninja
  NINJA_ROOT=$(mktemp -d)
  mkdir -p ${INSTALL_ROOT}/bin
  pushd ${NINJA_ROOT}/bin
  NINJA_VERSION=ninja-1.9.0.g99df1.kitware.dyndep-1.jobserver-1
  wget https://github.com/Kitware/ninja/releases/download/${NINJA_VERSION}/${NINJA_VERSION}_x86_64-linux-gnu.tar.gz -O ninja.tar.gz
  tar -xf ninja.tar.gz --strip 1
  mv ninja ${INSTALL_ROOT}/bin
  popd
  echo "Installed Ninja version: $(ninja --version | head -1)"
fi
  
###############################################################################
# end of scripts/travis/install.sh
###############################################################################
