#!/bin/bash
cd $(dirname "$(realpath "$0")")
set -Eeox pipefail

EXAMPLE_ROOT=$PWD

(
    cd cpp/example

    # rm -rf build

    cmake -S . -B build
    cmake --build build
    ctest --test-dir build
)
(
    cd python/example

    # rm -rf _skbuild

    CMAKE_ARGS=""
    CMAKE_ARGS="$CMAKE_ARGS -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON"
    CMAKE_ARGS="$CMAKE_ARGS -Dexample_DIR=$EXAMPLE_ROOT/cpp/example/build"

    SETUPTOOLS_ENABLE_FEATURES="legacy-editable"

    pip install --no-deps --no-build-isolation -e . -V

    pytest
)
