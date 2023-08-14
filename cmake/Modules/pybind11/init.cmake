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

#]=======================================================================]
macro(rapids_pybind11_init)
  list(APPEND CMAKE_MESSAGE_CONTEXT "rapids.pybind11.init")
  # Only initialize once.
  if(NOT DEFINED RAPIDS_PYBIND11_INITIALIZED)

    # find_package(PythonExtensions REQUIRED)
    find_package(pybind11 CONFIG REQUIRED)

    # Flag
    set(RAPIDS_PYBIND11_INITIALIZED TRUE)
  endif()
endmacro()