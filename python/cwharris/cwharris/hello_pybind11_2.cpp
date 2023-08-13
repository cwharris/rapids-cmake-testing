#include <iostream>
#include <pybind11/pybind11.h>

namespace py = pybind11;

int return_three() {
    return 3;
}

PYBIND11_MODULE(hello_pybind11_2, m) {
    m.doc() = "hello_pybind11_2";
    m.def("return_three", &return_three, "Returns 3");
}
