
# What

This repo contains a small intro to C and CMake. The power-point presentation and some experimental CMake-examples will be given at a tech-night to students.

__DISCLAIMER__ Nothing has been proof-read and I am a mere SW developer. If nothing else, see this as inspiration.

# Presentation

See [presentation.pptx](presentation.pptx).

# CMake

See folder [examples](examples).

The examples folder will contain CMake examples, with some tools integration.

1) The first example is the most basic setup one can have.
2) The second example is more descriptive of how a project is set up.
3) The third example is more complex, and is one way to use CMake, CMake has it limitations and this is an example. The third example contains integration of code insturmentation using sanitizers and static analysis. To see what the different tools can find, the example code has some bugs.

# Usage

Each example has a README describing how to use and if there are any special prerequisites.

# Prerequisites

Tested with GCC 7.4.0, Clang 6.0.0 and CMake 3.10. Newer versions should work, older might have issues with compile flags, try to updating the CMake files if there are issues. I have allowed CMake to generate default build system files for me, makefiles that would be, but I hope other things works too.
