cmake_minimum_required(VERSION 3.20)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules")

include(../../fetch_rapids.cmake)
include(rapids-cmake)
include(rapids-cython)
include(rapids-pybind11)

project(cwharris_python)

rapids_cython_init()
rapids_pybind11_init()

add_subdirectory("cwharris")
