#!/bin/sh
###############################################################################
# File  : scripts/travis/install.sh
#
# Install dependencies. 
###############################################################################

set -e

mkdir -p ${INSTALL_ROOT}/bin

if [ "${GENERATOR}" = "ninja" ]; then
  # Install Ninja
  cd $(mktemp -d)
  NINJA_VERSION=1.9.0.g99df1.kitware.dyndep-1.jobserver-1
  curl -L https://github.com/Kitware/ninja/releases/download/v${NINJA_VERSION}/ninja-${NINJA_VERSION}_x86_64-linux-gnu.tar.gz \
    | tar -xz --strip 1
  mv ninja ${INSTALL_ROOT}/bin
  echo "Installed Ninja version: $(ninja --version | head -1)"
fi
  
echo "Fortran compiler: ${FC}"
if [ -n "${FC}" ]; then
  echo "Compiler version: $(${FC} | head -1)"
fi

if [ "${FLIBCPP_DEV}" = "ON" ]; then
  # Install SWIG-fortran
  cd $(mktemp -d)
  git clone --depth=1 https://github.com/swig-fortran/swig
  pushd swig 
  echo "SWIG git revision: $(git rev-parse HEAD)"
  ./autogen.sh
  ./configure --prefix="${INSTALL_ROOT}" --without-alllang --with-fortran=$FC
  make
  make install
  echo "Installed SWIG version: $(swig -version | grep SWIG)"
fi

###############################################################################
# end of scripts/travis/install.sh
###############################################################################
