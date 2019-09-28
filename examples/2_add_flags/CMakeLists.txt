cmake_minimum_required(VERSION 3.10) # The version I happen to use, older
                                     # versions might work, newer will, update
                                     # to the version you use.

project(add_flags
        VERSION 0.0.0
        DESCRIPTION "Example of CMake in a C project"
        LANGUAGES C)

# Make sure user defines a build type, if not, inform user that we chose one.
if(NOT CMAKE_BUILD_TYPE)
  message(WARNING "No build type set, default to Release. CMake can be run with e.g. -DCMAKE_BUILD_TYPE=Debug, Release, RelWithDebInfo.")
  set(CMAKE_BUILD_TYPE Release CACHE String "No build type set, we default to release." FORCE)
endif()

# To the fun parts!
add_subdirectory(src)
