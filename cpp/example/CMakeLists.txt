cmake_minimum_required(VERSION 3.20)

project(example)

add_library(
    example
    src/math.cpp
)

target_include_directories(
    example
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)