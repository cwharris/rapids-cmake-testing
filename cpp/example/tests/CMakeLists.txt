include(${rapids-cmake-dir}/cpm/gtest.cmake)

add_executable(
    example_test
    math_test.cpp
)

target_link_libraries(
    example_test
    PRIVATE
        GTest::gtest_main
)

rapids_cpm_gtest()
include(GoogleTest)
gtest_discover_tests(example_test)
