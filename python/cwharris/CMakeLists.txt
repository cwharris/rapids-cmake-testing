cmake_minimum_required(VERSION 3.20)

include(../../fetch_rapids.cmake)
include(rapids-cmake)
include(rapids-cython)

project(cwharris_python)

rapids_cython_init()

add_subdirectory("cwharris")
