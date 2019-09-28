cmake_minimum_required(VERSION 3.10) # The version I happen to use, older
                                     # versions might work, newer will, update
                                     # to the version you use.

project(things_happen
        VERSION 0.0.0
        DESCRIPTION "Example of CMake and tools in a C project"
        LANGUAGES C)

# All compile commands are written to file "compile_commands.json" which can be
# read by other tools.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Make sure user defines a build type, if not, inform user that we chose one.
if(NOT CMAKE_BUILD_TYPE)
  message(WARNING "No build type set, default to Release. CMake can be run with e.g. -DCMAKE_BUILD_TYPE=Debug, Release, RelWithDebInfo.")
  set(CMAKE_BUILD_TYPE Release CACHE String "No build type set, we default to release." FORCE)
endif()

# This adds files with custom CMake functions, available for all projects we add with "add_subdirectory()" below.
# One should not use CMake include, but for global functions it's handy. 
include(flags.cmake)
include(clang_tidy.cmake)

# To the fun parts!
add_subdirectory(app_ok)
add_subdirectory(app_asan_clang_tidy)

