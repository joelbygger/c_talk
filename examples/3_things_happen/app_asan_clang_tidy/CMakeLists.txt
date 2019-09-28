set(my_app_name "app_asan_clang_tidy")
set(my_app_srcs src/main.c src/secret/foo.c)
set(my_app_priv_include_folders src/secret)

add_executable(${my_app_name} ${my_app_srcs})
target_include_directories(${my_app_name} PRIVATE ${my_app_priv_include_folders})

target_compile_options(${my_app_name} PRIVATE ${MY_C_COMPILE_FLAGS})
target_link_libraries(${my_app_name} PRIVATE ${MY_EXTRA_LINKER_LIBS})

# Create a command to execute built binary.
add_custom_target(${my_app_name}_run
                  COMMAND ${my_app_name}
                  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                  COMMENT "Run generated binary in ${CMAKE_CURRENT_SOURCE_DIR}")

if(TIDY)
  add_clang_tidy_to_target(NAME
                           ${my_app_name}
                           SOURCES
                           ${my_app_srcs}
                           INCLUDE_PRIVATE
                           ${my_app_priv_include_folders})
endif()

# Make sure we compile wiht latest standard, no reason not to. CMake will use
# this info to make sure the cmpiler it selects is compliant.
set_target_properties(${my_app_name} PROPERTIES C_STANDARD_REQUIRED ON)
set_target_properties(${my_app_name} PROPERTIES C_STANDARD 11)
