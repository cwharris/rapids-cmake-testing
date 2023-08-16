#include <iostream>
#include <string.h>

#include <pybind11/pybind11.h>

#include <example/math.hpp>

namespace py = pybind11;

int add(int a, int b)
{
    return example::math::add(a, b);
}

PYBIND11_MODULE(add, m)
{
    m.doc() = "add";
    m.def("add", &add, py::arg("a"), py::arg("b"), "Add two arguments");
}
