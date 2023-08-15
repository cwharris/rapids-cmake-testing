#!/bin/bash
cd $(dirname "$(realpath "$0")")
set -Eeox pipefail

EXAMPLE_ROOT=$PWD

(
    cd cpp/example

    rm -rf build
    cmake -S . -B build
    cmake --build build
    cmake --install build --prefix build/install
)
(
    cd python/example

    CMAKE_ARGS="-DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON -Dexample_DIR=$EXAMPLE_ROOT/cpp/example/build --debug-find-pkg=example" \
    SETUPTOOLS_ENABLE_FEATURES="legacy-editable" \
    pip install --no-deps --no-build-isolation -e . -V
)
