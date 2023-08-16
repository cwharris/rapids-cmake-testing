rapids_cython_create_modules(
    CXX
    MODULE_PREFIX example_
    LINKED_LIBRARIES example::example
    SOURCE_FILES
        hello_cython.pyx
)

rapids_pybind11_create_modules(
    MODULE_PREFIX example_
    LINKED_LIBRARIES example::example
    SOURCE_FILES
        hello_pybind11.cpp
)
