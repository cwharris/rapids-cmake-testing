(
    cd cpp/cwharris
    cmake -S . -B build
    cmake --build build
)
(
    cd python/cwharris
    SETUPTOOLS_ENABLE_FEATURES="legacy-editable" pip install --no-deps --no-build-isolation -e . -V
)
