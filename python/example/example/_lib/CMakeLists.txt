rapids_pybind11_create_modules(
    MODULE_PREFIX example_
    LINKED_LIBRARIES example::example
    SOURCE_FILES
        hello.cpp
        add.cpp
)
