#
# Runtime sanitizers.
#

# Set for all sanitizers.
set(MY_C_COMPILE_FLAGS
    ${MY_C_COMPILE_FLAGS}
    # We want to stop all execution when an error occurs. Applies to all
    # sanitizers that supports it, and if the lib has it enabled.
    -fno-sanitize-recover=all
    # To get proper stack traces. Allows the fast unwinder to function properly,
    # get proper debug info in binary.
    # *SAN_SYMBOLIZER_PATH must be available and point to llvm-symbolizer.
    -fno-omit-frame-pointer)

# UBSAN effects runtime & mem. very little, we let it always be active.
set(MY_C_COMPILE_FLAGS ${MY_C_COMPILE_FLAGS} -fsanitize=undefined)
set(MY_EXTRA_LINKER_LIBS ${MY_EXTRA_LINKER_LIBS} -fsanitize=undefined)

if(ASAN) # True if CMake called with -DASAN=1. Should use -01 or higher. ASAN
         # implicitly activates sanitize=leak.
  message("---- Compiling with address sanitizer.")
  set(MY_C_COMPILE_FLAGS ${MY_C_COMPILE_FLAGS} -fsanitize=address
                         -fsanitize-address-use-after-scope)

  # ASAN must come first in list!
  set(MY_EXTRA_LINKER_LIBS -fsanitize=address ${MY_EXTRA_LINKER_LIBS})
endif()

if("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
  set(MY_C_COMPILE_FLAGS
      ${MY_C_COMPILE_FLAGS}
      -Wall
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
      -ftrapv
      )

      # >8 -fstack-clash-protection
  # I think it can be argued that the warnings below should only be part of
  # Debug build, but I think they can be part of release.
  set(MY_C_COMPILE_FLAGS
      ${MY_C_COMPILE_FLAGS}
      -Wstack-protector
      -fstack-protector-all
      -fstack-protector-strong
      -fstack-check
      -D_FORTIFY_SOURCE=2)

  #
  # Runtime sanitizers.
  #
  # For UBSAN
  set(MY_C_COMPILE_FLAGS
      ${MY_C_COMPILE_FLAGS}
      # Suboptions GCC doesen't add by default:
      -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow
      # -fsanitize-undefined-trap-on-error <- removes need for the UBSAN lib, as
      # a consequence the crash report will give us very little.
      )

  if(ASAN)
    if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU" AND CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 8.3)
        # Both these also req. ASAN_OPTIONS detect_invalid_pointer_pairs=2, seems
        # like they don't exists in Clang? Defaulted?
        set(MY_C_COMPILE_FLAGS ${MY_C_COMPILE_FLAGS} -fsanitize=pointer-compare
                            -fsanitize=pointer-subtract)
    endif()
  endif()

elseif("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
  set(MY_C_COMPILE_FLAGS
      ${MY_C_COMPILE_FLAGS}
      # As long as all warnings works, I'll stick to it, can be changed alter,
      # but easier and maybe safer this way.
      -Weverything -Wpedantic
      # Ignore C++98 backwards compatibility and warnings about classes etc.
      # being being padded.
      -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-padded)
endif()
