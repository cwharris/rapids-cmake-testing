cmake_minimum_required(VERSION 3.20)

include(../../fetch_rapids.cmake)
include(rapids-cmake)
include(rapids-cython)
# include(rapids-pybind11)

project(cwharris_python)

rapids_cython_init()
# rapids_pybind11_init()

find_package(pybind11 CONFIG REQUIRED)

add_subdirectory("cwharris")
