#include <iostream>
#include <pybind11/pybind11.h>
#include <example/math.hpp>

namespace py = pybind11;

int return_three() {
    return example::math::add(1, 2);
}

PYBIND11_MODULE(hello_pybind11, m) {
    m.doc() = "hello_pybind11";
    m.def("return_three", &return_three, "Returns 3");
}
