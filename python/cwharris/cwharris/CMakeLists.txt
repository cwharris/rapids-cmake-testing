# function(rapids_pybind11_create_modules)
#   include(${CMAKE_CURRENT_FUNCTION_LIST_DIR}/detail/verify_init.cmake)
#   rapids_pybind11_verify_init()

#   list(APPEND CMAKE_MESSAGE_CONTEXT "rapids.pybind11.create_modules")

#   set(_rapids_pybind11_options CXX)
#   set(_rapids_pybind11_one_value INSTALL_DIR MODULE_PREFIX)
rapids_cython_create_modules(
    CXX
    SOURCE_FILES hello.pyx
    MODULE_PREFIX cwharris
)