set(my_lib_name "secret_lib")
set(my_lib_srcs foo.c)
set(my_lib_public_include_folders ${CMAKE_CURRENT_SOURCE_DIR})

add_library(${my_lib_name} STATIC ${my_lib_srcs})
target_include_directories(${my_lib_name} PUBLIC ${my_lib_public_include_folders})
target_compile_options(${my_lib_name} PRIVATE ${MY_C_COMPILE_FLAGS})
target_link_libraries(${my_lib_name} PRIVATE ${MY_EXTRA_LINKER_LIBS})

# Make sure we compile wiht latest standard, no reason not to. CMake will use
# this info to make sure the cmpiler it selects is compliant.
set_target_properties(${my_lib_name} PROPERTIES C_STANDARD_REQUIRED ON)
set_target_properties(${my_lib_name} PROPERTIES C_STANDARD 11)
