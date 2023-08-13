cmake_minimum_required(VERSION 3.20)

project(cwharris)

add_library(
    cwharris
    src/math.cpp
)

target_include_directories(
    cwharris
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)