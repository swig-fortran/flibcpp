#!/bin/sh -ex
###############################################################################
# File  : scripts/travis/install.sh
#
# Install dependencies. 
###############################################################################

echo "Fortran compiler: ${FC}"
if [ -n "${FC}" ]; then
  echo "Compiler version: $(${FC} | head -1)"
fi

if [ "${FLIBCPP_DEV}" == "ON" ]; then
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

if [ "${CMAKE_GENERATOR}" == "Ninja" ]; then
  # Install Ninja
  NINJA_ROOT=$(mktemp -d)
  mkdir -p ${NINJA_ROOT}/bin
  pushd ${NINJA_ROOT}/bin
  wget https://github.com/ninja-build/ninja/releases/download/v1.9.0/ninja-linux.zip
  unzip ninja-linux.zip
  popd
  export PATH=${NINJA_ROOT}/bin:${PATH}
  echo "Ninja version: $(ninja --version | head -1)"
fi
  
###############################################################################
# end of scripts/travis/install.sh
###############################################################################
