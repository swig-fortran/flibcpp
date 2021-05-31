#!/bin/sh -ex
###############################################################################
# File  : scripts/travis/install.sh
#
# Install dependencies.
###############################################################################

mkdir -p ${INSTALL_ROOT}/bin

echo "CMake version:  $(${CMAKE} --version | head -1)"
echo "CTest version:  $(ctest --version | head -1)"
echo "Ninja version: $(ninja --version || echo 'n/a')"
echo "Fortran compiler version: $(${FC} --version | head -1)"

if [ "${FLIBCPP_DEV}" = "ON" ]; then
  # Install SWIG-fortran
  cd $(mktemp -d)
  git clone --depth=1 https://github.com/swig-fortran/swig
  cd swig
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
