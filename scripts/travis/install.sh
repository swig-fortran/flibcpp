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

if [ "${FLIBCPP_DEV}" = "ON" ]; then
  # Install SWIG-fortran
  git clone --depth=1 https://github.com/swig-fortran/swig
  pushd swig 
  echo "SWIG git revision: $(git rev-parse HEAD)"
  ./autogen.sh
  ./configure --prefix=/usr --without-alllang --with-fortran=$FC
  make
  sudo make install
  popd
fi

if [ "${CMAKE_GENERATOR}" = "Ninja" ]; then
  # Install Ninja
  NINJA_ROOT=$(mktemp -d)
  mkdir -p ${NINJA_ROOT}/bin
  pushd ${NINJA_ROOT}/bin
  NINJA_VERSION=ninja-1.9.0.g99df1.kitware.dyndep-1.jobserver-1
  wget https://github.com/Kitware/ninja/releases/download/${NINJA_VERSION}/${NINJA_VERSION}_x86_64-linux-gnu.tar.gz -O ninja.tar.gz
  tar -xf ninja.tar.gz --strip 1
  popd
  export PATH=${NINJA_ROOT}/bin:${PATH}
  echo "Ninja version: $(ninja --version | head -1)"
fi
  
###############################################################################
# end of scripts/travis/install.sh
###############################################################################
