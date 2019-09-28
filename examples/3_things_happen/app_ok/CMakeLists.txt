add_subdirectory(secret)

set(my_app_name "app_ok")
set(my_app_srcs main.c)

add_executable(${my_app_name} ${my_app_srcs})
target_compile_options(${my_app_name} PRIVATE ${MY_C_COMPILE_FLAGS})
target_link_libraries(${my_app_name} PRIVATE secret_lib)

# Create a command to execute built binary.
add_custom_target(${my_app_name}_run
                  COMMAND ${my_app_name}
                  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                  COMMENT "Run generated binary in ${CMAKE_CURRENT_SOURCE_DIR}")

# On GCC, this structure of CMake with libs and executables does not play well with my integration of clang_tidy,
# so we simply ignore it here, it can be called in other ways though.
# It works with clang as compiler, so just use clang...
if("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
  if(TIDY)
    add_clang_tidy_to_target(NAME
                            ${my_app_name}
                            SOURCES
                            ${my_app_srcs}
                            INCLUDE_PRIVATE
                            ${my_app_priv_include_folders})
  endif()
endif()

# Make sure we compile wiht latest standard, no reason not to. CMake will use
# this info to make sure the cmpiler it selects is compliant.
set_target_properties(${my_app_name} PROPERTIES C_STANDARD_REQUIRED ON)
set_target_properties(${my_app_name} PROPERTIES C_STANDARD 11)
