cmake_minimum_required(VERSION 3.20)

include(../../fetch_rapids.cmake)
include(rapids-cmake)
include(rapids-export)

project(example)

add_library(example SHARED
    src/math.cpp
)

add_library(example::example ALIAS example)

target_include_directories(
    example
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

install(TARGETS example EXPORT example-exports)

# install(EXPORT example-exports DESTINATION lib/example)

# rapids_export_package(
#     BUILD
#         example
#         example-exports
#     GLOBAL_TARGETS
#         example::example
# )

# rapids_export_package(
#     INSTALL
#         example
#         example-exports
#     GLOBAL_TARGETS
#         example::example
# )

# rapids_export(
#     BUILD example
#     EXPORT_SET example-exports
#     GLOBAL_TARGETS
#         example::example
# )

# rapids_export(
#     INSTALL example
#     EXPORT_SET example-exports
#     GLOBAL_TARGETS
#         example::example
# )