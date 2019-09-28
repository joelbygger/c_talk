
# What

A somewhat complex CMake example project. It is intended to show what can be done and might perhaps be seen as a way to handle projects were several things are built.

The CMake structure makes it quite easy to make sure all compilation/ linker flags are added to all targets, without forcing it, one can still choose.

## Build targets

- app_asan_clang_tidy : has some bugs that enabling ASAN and Clang Tidy will reveal. Perhaps the bugs can be detected by UBSAN (which is always ative) or just standard compiler checks, if so, ignore what you see and activate the additional tools, they are nice.
- app_ok : intended to show in even more detail how CMake is intended can be used, where each foder creates a library which is linked together in the end to an application binary. Should not contain any bugs or things for comiler to complain on.

## CMake configuration

E.g.:

```bash
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug  ..
```

or perhaps:

```bash
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=/usr/bin/clang-8 ..
```

# Sanitizers

Sanitizers use code instrumentaiton to find and alert the user when an undesired behaviour occurs in an application when application is running. Sanitizers are part of GCC ang Clang.

## UBSAN

Undefined Behavior sanitizer is also always added <https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html>, during project runtime it will crash the application when undefined behaviour occurs.

## ASAN

Address sanitizer can be added with a flag to CMake, be project is configured. It alerts user on e.g. user after free, out of bounds access etc. <https://clang.llvm.org/docs/AddressSanitizer.html>

```bash
cmake -DASAN=1 ..
```

# Static analysis

Clang tidy is used. Requires Clang compiler etc. It can be used with GCC as main compiler. For more info see [clang_tidy.cmake](clang_tidy.cmake). Activated with:

```bash
cmake -DTIDY=1 ..
```

Not all examples has this enabled for all compilers, see appropriate CMake files. If you want to run it standalone, make sure CMake has generated a compile_commands.json (and clang-tidy is installed) and execute e.g.:

```bash
python3 /usr/bin/run-clang-tidy-8.py -header-filter='.*' -checks='*'
```
