from setuptools import find_packages
from skbuild import setup


packages = find_packages(include="*")

setup(
    packages=packages
)
