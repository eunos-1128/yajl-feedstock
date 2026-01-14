#!/bin/bash
set -ex

EXTRA_CMAKE_ARGS=""
if [[ ${target_platform} == "osx-"* ]]; then
  EXTRA_CMAKE_ARGS="${EXTRA_CMAKE_ARGS} -DCMAKE_MACOSX_RPATH=ON"
fi

cmake -S . -B build \
  ${CMAKE_ARGS} \
  -DCMAKE_EXE_LINKER_FLAGS="-Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib" \
  ${EXTRA_CMAKE_ARGS}

cmake --build build --parallel ${CPU_COUNT}
cmake --build build --target test --parallel ${CPU_COUNT}
cmake --install build --parallel ${CPU_COUNT}
