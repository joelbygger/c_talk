
add_executable(app_add_flags main.c foo.c)

target_include_directories(app_add_flags
                           PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}) # Header can be found in this directory.

if("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
  target_compile_options(app_add_flags
                         PRIVATE -Wall
                                 -Wextra
                                 -Wshadow
                                 -Wpedantic
                                 -Wunused
                                 -Wconversion
                                 -Wsign-conversion
                                 -Wduplicated-cond
                                 -Wduplicated-branches
                                 -Wlogical-op
                                 -Wnull-dereference
                                 -Wdouble-promotion
                                 -Wformat=2
                                 -Wpointer-arith
                                 -Wcast-qual
                                 -Wswitch-bool
                                 -Wswitch-enum
                                 -Winline
                                 -Wcast-align
                                 -Wmissing-declarations
                                 -Wshadow
                                 -fasynchronous-unwind-tables
                                 -fexceptions
                                 -ftrapv)
elseif("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
  target_compile_options(app_add_flags
                         PRIVATE -Weverything -Wpedantic)
endif()

# Make sure we compile wiht latest standard, no reason not to. CMake will use
# this info to make sure the cmpiler it selects is compliant.
set_target_properties(app_add_flags PROPERTIES C_STANDARD_REQUIRED ON)
set_target_properties(app_add_flags PROPERTIES C_STANDARD 11)

target_link_libraries(app_add_flags)
