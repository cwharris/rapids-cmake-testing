#include <iostream>
#include <string.h>

#include <pybind11/pybind11.h>

#include <example/math.hpp>

namespace py = pybind11;

void hello(std::string name)
{
    printf("Hello, %s!\n", name.c_str());
}

PYBIND11_MODULE(hello, m)
{
    m.doc() = "hello";
    m.def("hello", &hello, py::arg("name"), "Say hello");
}
