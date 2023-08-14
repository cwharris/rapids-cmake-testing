#!/bin/bash
cd $(dirname "$(realpath "$0")")
set -Eeox pipefail

(
    cd cpp/example
    cmake -S . -B build
    cmake --build build
)
(
    cd python/example
    SETUPTOOLS_ENABLE_FEATURES="legacy-editable" pip install --no-deps --no-build-isolation -e . -V
)
