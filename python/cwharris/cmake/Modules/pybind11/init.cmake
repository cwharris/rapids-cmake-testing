# =============================================================================
# Copyright (c) 2023, NVIDIA CORPORATION.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions and limitations under
# the License.
# =============================================================================

include_guard(GLOBAL)

#[=======================================================================[.rst:
rapids_pybind11_init
------------------

.. versionadded:: v22.06.00

Perform standard initialization of any CMake build to create Python modules with pybind11.

.. code-block:: cmake

  rapids_pybind11_init()

Result Variables
^^^^^^^^^^^^^^^^
  :cmake:variable:`RAPIDS_PYBIND11_INITIALIZED` will be set to TRUE.
  :cmake:variable:`PYBIND11_FLAGS` will be set to a standard set of a flags to pass to the command line pybind11 invocation.

#]=======================================================================]
macro(rapids_pybind11_init)
  list(APPEND CMAKE_MESSAGE_CONTEXT "rapids.pybind11.init")
  # Only initialize once.
  if(NOT DEFINED RAPIDS_PYBIND11_INITIALIZED)
    # # Verify that we are using scikit-build.
    # if(NOT DEFINED SKBUILD)
    #   message(WARNING "rapids-pybind11 expects scikit-build to be active before being used. \
    #       The SKBUILD variable is not currently set, indicating that scikit-build \
    #       is not active, so builds may behave unexpectedly.")
    # else()
    #   # Access the variable to avoid unused variable warnings."
    #   message(TRACE "Accessing SKBUILD variable ${SKBUILD}")
    # endif()

    find_package(PythonExtensions REQUIRED)
    find_package(pybind11 CONFIG REQUIRED)

    # # Incorporate scikit-build patches.
    # include("${rapids-cmake-dir}/pybind11/detail/skbuild_patches.cmake")

    # if(NOT PYBIND11_FLAGS)
    #   set(PYBIND11_FLAGS "--directive binding=True,embedsignature=True,always_allow_keywords=True")
    # endif()

    # Flag
    set(RAPIDS_PYBIND11_INITIALIZED TRUE)
  endif()
endmacro()