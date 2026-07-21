#! /usr/bin/bash

mkdir -p build
cd build

# ${CMAKE_ARGS} carries conda-build's own -DCMAKE_BUILD_TYPE=Release
# (plus toolchain/strip paths) -- omitting it leaves CMAKE_BUILD_TYPE
# unset (this project's own CMakeLists.txt never defaults it either),
# producing an unoptimized, unstripped debug-info binary.
cmake ${CMAKE_ARGS} -DKFR_ENABLE_CAPI_BUILD=TRUE -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
      -DKFR_ENABLE_MULTIARCH=ON -DKFR_ARCHS="sse2;sse3;ssse3;sse41;sse42;avx;avx2;avx512" \
      -DCMAKE_CXX_COMPILER=clang++ -DKFR_WITH_CLANG=OFF \
      -DCMAKE_INSTALL_PREFIX=$PREFIX ..

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
make -j$NPROC
make install
