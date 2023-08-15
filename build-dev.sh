#!/bin/bash
cd $(dirname "$(realpath "$0")")
set -Eeox pipefail

# EXAMPLE_ROOT=$PWD

(
    cd cpp/example

    cmake -S . -B build
    cmake --build build
)
(
    cd python/example

    # export SKBUILD_CONFIGURE_OPTIONS="-Dexample_DIR=$EXAMPLE_ROOT/cpp/example/build --debug-find-pkg=example"
    SETUPTOOLS_ENABLE_FEATURES="legacy-editable" pip install --no-deps --no-build-isolation -e . -V
)
