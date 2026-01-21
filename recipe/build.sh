#!/bin/bash
set -ex

cmake -S . -B build ${CMAKE_ARGS} -DBUILD_SHARED_LIBS=ON
cmake --build build --parallel ${CPU_COUNT}

if [[ ${build_platform} == ${target_platform} || (${build_platform} != ${target_platform} && ${target_platform} != "osx-arm64") ]]; then 
  cmake --build build --target test --parallel ${CPU_COUNT}
fi

cmake --install build --parallel ${CPU_COUNT}
