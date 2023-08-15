cmake_minimum_required(VERSION 3.20)

include(../../fetch_rapids.cmake)
include(rapids-cmake)
include(rapids-export)
include(rapids-cpm)

project(example)

rapids_cpm_init()

add_library(example SHARED
    src/math.cpp
)

add_library(example::example ALIAS example)

enable_testing()
add_subdirectory(tests)

target_include_directories(
    example
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    INTERFACE $<INSTALL_INTERFACE:include>
)

install(
    TARGETS example
    EXPORT example-exports
)

include(GNUInstallDirs)
install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/example
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

rapids_export(
    BUILD example
    EXPORT_SET example-exports
    NAMESPACE example::
    GLOBAL_TARGETS
        example
)

rapids_export(
    INSTALL example
    EXPORT_SET example-exports
    GLOBAL_TARGETS
        example
)