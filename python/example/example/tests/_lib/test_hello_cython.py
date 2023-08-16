import example._lib.hello_cython

def test_hello():
    example._lib.hello_cython.hello("world")
