
rapids_cython_create_modules(
    CXX
    SOURCE_FILES hello_cython.pyx
    MODULE_PREFIX cwharris
)

# rapids_pybind11_create_modules(
#     SOURCE_FILES hello_pybind11.cpp
#     MODULE_PREFIX cwharris
# )

pybind11_add_module(_cwharris_hello_pybind11 MODULE hello_pybind11.cpp)
set_target_properties(_cwharris_hello_pybind11 PROPERTIES OUTPUT_NAME hello_pybind11)
cmake_path(RELATIVE_PATH CMAKE_CURRENT_SOURCE_DIR BASE_DIRECTORY "${PROJECT_SOURCE_DIR}"
           OUTPUT_VARIABLE _PYBIND_INSTALL_DIR)
install(TARGETS _cwharris_hello_pybind11 DESTINATION ${_PYBIND_INSTALL_DIR})