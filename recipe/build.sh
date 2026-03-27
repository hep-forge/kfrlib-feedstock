#! /usr/bin/bash

mkdir -p build
cd build

cmake -DKFR_ENABLE_CAPI_BUILD=TRUE -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
      -DKFR_ENABLE_MULTIARCH=ON -DKFR_ARCHS="sse2;sse3;ssse3;sse41;sse42;avx;avx2;avx512" \
      -DCMAKE_CXX_COMPILER=clang++ -DKFR_WITH_CLANG=OFF \
      -DCMAKE_INSTALL_PREFIX=$PREFIX ..

make -j$(nproc)
make install
