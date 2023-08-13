if(NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/CWHARRIS_RAPIDS.cmake)
  file(DOWNLOAD https://raw.githubusercontent.com/rapidsai/rapids-cmake/branch-23.10/RAPIDS.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/CWHARRIS_RAPIDS.cmake)
endif()
include(${CMAKE_CURRENT_BINARY_DIR}/CWHARRIS_RAPIDS.cmake)
