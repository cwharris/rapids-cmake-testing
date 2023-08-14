cmake_minimum_required(VERSION 3.20)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/Modules") # add local modules

include(../../fetch_rapids.cmake)
include(rapids-cmake)
include(rapids-cython)
include(rapids-pybind11) # this is a local module

project(example_python)

rapids_cython_init()
rapids_pybind11_init()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory("example")
