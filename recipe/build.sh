#!/bin/bash

# Make a build folder and change to it.
mkdir build
cd build


# Configure using the CMakeFiles
cmake -G "Ninja"  \
      -DBTK_WRAP_PYTHON:BOOL=1 \
      -DCMAKE_INSTALL_PREFIX:FILEPATH="${LIBRARY_PREFIX}" \
      -DCMAKE_PREFIX_PATH:PATH="${LIBRARY_PREFIX}" \
      -DPYTHON_LIBRARY="${PREFIX}/lib/libpython${PY_VER}m${SHLIB_EXT}" \
      -DPYTHON_INCLUDE_DIR="${PREFIX}/include/python${PY_VER}m" \
      -DNUMPY_INCLUDE_DIR="${SP_DIR}/numpy/core/include" \
      -DNUMPY_VERSION="${NPY_VER}" \
      -DCMAKE_PREFIX_PATH:PATH="${PREFIX}" \
      -DBUILD_DOCUMENTATION:BOOL=0 \
      -DCMAKE_BUILD_TYPE:STRING=Release \
      -DBUILD_SHARED_LIBS:BOOL=1 \
      ${SRC_DIR}


nmake

nmake install

# Not sure if we should do this on mac/linux
# RMDIR /Q/S "%LIBRARY_PREFIX%\share\btk-0.4dev"

# Collect bin/_btk.pyd and bin/btk.py move it to site_packages
cp "bin/btk.py" "${SP_DIR}/btk.py"
cpp "bin/_btk${SHLIB_EXT}" "${SP_DIR}/_btk${SHLIB_EXT}"

