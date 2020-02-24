option(BUILD_POLYBAR "Build polybar executable" ON)
option(BUILD_IPC_MSG "Build ipc messager" ON)
option(BUILD_TESTS "Build testsuite" OFF)
# include(CMakeDependentOption)
# CMAKE_DEPENDENT_OPTION(BUILD_IPC_MSG "Build ipc messager" ON "BUILD_POLYBAR" OFF)
# CMAKE_DEPENDENT_OPTION(BUILD_TESTS "Build testsuite" OFF "BUILD_POLYBAR" OFF)

option(BUILD_DOC "Build documentation" ON)

if (BUILD_POLYBAR OR BUILD_TESTS OR BUILD_IPC_MSG)
  set(BUILD_CXX ON INTERNAL)
else()
  set(BUILD_CXX OFF INTERNAL)
endif()

if (BUILD_POLYBAR OR BUILD_TESTS)
  set(BUILD_LIBPOLY ON INTERNAL)
else()
  set(BUILD_LIBPOLY OFF INTERNAL)
endif()

set(SPHINX_BUILD "sphinx-build" CACHE STRING "Name/Path of the sphinx-build executable to use.")
checklib(BUILD_DOC "binary" "${SPHINX_BUILD}")
