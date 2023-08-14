# =============================================================================
# Copyright (c) 2022-2023, NVIDIA CORPORATION.
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
rapids_pybind11_create_modules
----------------------------

.. versionadded:: v22.06.00

Generate C(++) from pybind11 and create Python modules.

.. code-block:: cmake

  rapids_pybind11_create_modules([CXX] [SOURCE_FILES <src1> <src2> ...] [LINKED_LIBRARIES <lib1> <lib2> ... ]  [INSTALL_DIR <install_path>] [MODULE_PREFIX <module_prefix>] )

Creates a pybind11 target for each provided source file, then adds a
corresponding Python extension module. Each built library has its RPATH set to
$ORIGIN.

.. note::
  Requires :cmake:command:`rapids_pybind11_init` to be called before usage.

``SOURCE_FILES``
  The list of pybind11 source files to be built into Python extension modules.
  Note that this function assumes that pybind11 source files have a one-one
  correspondence with extension modules to build, i.e. for every `<Name>.pyx`
  in SOURCE_FILES we assume that `<Name>.pyx` is a pybind11 source file for which
  an extension module `<Name>` should be built.

``LINKED_LIBRARIES``
  The list of libraries that need to be linked into all modules. In RAPIDS,
  this list usually contains (at minimum) the corresponding C++ libraries.

``INSTALL_DIR``
  The path relative to the installation prefix so that it can be converted to
  an absolute path in a relocatable way. If not provided, defaults to the path
  to CMAKE_CURRENT_SOURCE_DIR relative to PROJECT_SOURCE_DIR.

``MODULE_PREFIX``
  A prefix used to name the generated library targets. This functionality is
  useful when multiple pybind11 modules in different subpackages of the the same
  project have the same name. The default prefix is the empty string.

``ASSOCIATED_TARGETS``
  A list of targets that are associated with the pybind11 targets created in this
  function. The target<-->associated target mapping is stored and may be
  leveraged by the following functions:

  - :cmake:command:`rapids_pybind11_add_rpath_entries` accepts a path for an
    associated target and updates the RPATH of each target with which that
    associated target is associated.

Result Variables
^^^^^^^^^^^^^^^^
  :cmake:variable:`RAPIDS_PYBIND11_CREATED_TARGETS` will be set to a list of
  targets created by this function.

#]=======================================================================]
function(rapids_pybind11_create_modules)
  include(${CMAKE_CURRENT_FUNCTION_LIST_DIR}/detail/verify_init.cmake)
  rapids_pybind11_verify_init()

  list(APPEND CMAKE_MESSAGE_CONTEXT "rapids.pybind11.create_modules")

  set(_rapids_pybind11_options)
  set(_rapids_pybind11_one_value INSTALL_DIR MODULE_PREFIX)
  set(_rapids_pybind11_multi_value SOURCE_FILES LINKED_LIBRARIES ASSOCIATED_TARGETS)
  cmake_parse_arguments(_RAPIDS_PYBIND11 "${_rapids_pybind11_options}" "${_rapids_pybind11_one_value}"
                        "${_rapids_pybind11_multi_value}" ${ARGN})

  set(CREATED_TARGETS "")

  if(NOT DEFINED _RAPIDS_PYBIND11_MODULE_PREFIX)
    set(_RAPIDS_PYBIND11_MODULE_PREFIX "")
  endif()

  foreach(pybind11_filename IN LISTS _RAPIDS_PYBIND11_SOURCE_FILES)
    # Generate a reasonable module name.
    cmake_path(GET pybind11_filename FILENAME pybind11_module)
    cmake_path(REMOVE_EXTENSION pybind11_module)

    # Save the name of the module without the provided prefix so that we can control the output.
    set(pybind11_module_filename "${pybind11_module}")
    string(PREPEND pybind11_module ${_RAPIDS_PYBIND11_MODULE_PREFIX})

    # Generate C++ from pybind11 and create a library for the resulting extension module to compile.
    pybind11_add_module(${pybind11_module} MODULE "${pybind11_filename}")

    # The final library name must match the original filename and must ignore the prefix.
    set_target_properties(${pybind11_module} PROPERTIES LIBRARY_OUTPUT_NAME ${pybind11_module_filename})

    # Link the module to the requested libraries
    if(DEFINED _RAPIDS_PYBIND11_LINKED_LIBRARIES)
      target_link_libraries(${pybind11_module} ${_RAPIDS_PYBIND11_LINKED_LIBRARIES})
    endif()

    # Compute the install directory relative to the source and rely on installs being relative to
    # the CMAKE_PREFIX_PATH for e.g. editable installs.
    if(NOT DEFINED _RAPIDS_PYBIND11_INSTALL_DIR)
      cmake_path(RELATIVE_PATH CMAKE_CURRENT_SOURCE_DIR BASE_DIRECTORY "${PROJECT_SOURCE_DIR}"
                 OUTPUT_VARIABLE _RAPIDS_PYBIND11_INSTALL_DIR)
    endif()
    install(TARGETS ${pybind11_module} DESTINATION ${_RAPIDS_PYBIND11_INSTALL_DIR})

    # Default the INSTALL_RPATH for all modules to $ORIGIN.
    if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
      set(platform_rpath_origin "@loader_path")
    else()
      set(platform_rpath_origin "$ORIGIN")
    endif()
    set_target_properties(${pybind11_module} PROPERTIES INSTALL_RPATH "${platform_rpath_origin}")

    # Store any provided associated targets in a global list
    foreach(associated_target IN LISTS _RAPIDS_PYBIND11_ASSOCIATED_TARGETS)
      set_property(GLOBAL PROPERTY "rapids_pybind11_associations_${associated_target}"
                                   "${pybind11_module}" APPEND)
    endforeach()

    list(APPEND CREATED_TARGETS "${pybind11_module}")
  endforeach()

  set(RAPIDS_PYBIND11_CREATED_TARGETS ${CREATED_TARGETS} PARENT_SCOPE)
endfunction()