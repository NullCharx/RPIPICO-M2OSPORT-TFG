# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.18

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build

# Include any dependencies generated for this target.
include libs/dummy_lib/CMakeFiles/dummy_lib.dir/depend.make

# Include the progress variables for this target.
include libs/dummy_lib/CMakeFiles/dummy_lib.dir/progress.make

# Include the compile flags for this target's objects.
include libs/dummy_lib/CMakeFiles/dummy_lib.dir/flags.make

libs/dummy_lib/CMakeFiles/dummy_lib.dir/dummy_lib.c.obj: libs/dummy_lib/CMakeFiles/dummy_lib.dir/flags.make
libs/dummy_lib/CMakeFiles/dummy_lib.dir/dummy_lib.c.obj: ../libs/dummy_lib/dummy_lib.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object libs/dummy_lib/CMakeFiles/dummy_lib.dir/dummy_lib.c.obj"
	cd /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/libs/dummy_lib && /usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/dummy_lib.dir/dummy_lib.c.obj -c /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/libs/dummy_lib/dummy_lib.c

libs/dummy_lib/CMakeFiles/dummy_lib.dir/dummy_lib.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/dummy_lib.dir/dummy_lib.c.i"
	cd /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/libs/dummy_lib && /usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/libs/dummy_lib/dummy_lib.c > CMakeFiles/dummy_lib.dir/dummy_lib.c.i

libs/dummy_lib/CMakeFiles/dummy_lib.dir/dummy_lib.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/dummy_lib.dir/dummy_lib.c.s"
	cd /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/libs/dummy_lib && /usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/libs/dummy_lib/dummy_lib.c -o CMakeFiles/dummy_lib.dir/dummy_lib.c.s

# Object files for target dummy_lib
dummy_lib_OBJECTS = \
"CMakeFiles/dummy_lib.dir/dummy_lib.c.obj"

# External object files for target dummy_lib
dummy_lib_EXTERNAL_OBJECTS =

libs/dummy_lib/libdummy_lib.a: libs/dummy_lib/CMakeFiles/dummy_lib.dir/dummy_lib.c.obj
libs/dummy_lib/libdummy_lib.a: libs/dummy_lib/CMakeFiles/dummy_lib.dir/build.make
libs/dummy_lib/libdummy_lib.a: libs/dummy_lib/CMakeFiles/dummy_lib.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C static library libdummy_lib.a"
	cd /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/libs/dummy_lib && $(CMAKE_COMMAND) -P CMakeFiles/dummy_lib.dir/cmake_clean_target.cmake
	cd /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/libs/dummy_lib && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/dummy_lib.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
libs/dummy_lib/CMakeFiles/dummy_lib.dir/build: libs/dummy_lib/libdummy_lib.a

.PHONY : libs/dummy_lib/CMakeFiles/dummy_lib.dir/build

libs/dummy_lib/CMakeFiles/dummy_lib.dir/clean:
	cd /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/libs/dummy_lib && $(CMAKE_COMMAND) -P CMakeFiles/dummy_lib.dir/cmake_clean.cmake
.PHONY : libs/dummy_lib/CMakeFiles/dummy_lib.dir/clean

libs/dummy_lib/CMakeFiles/dummy_lib.dir/depend:
	cd /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/libs/dummy_lib /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/libs/dummy_lib /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/libs/dummy_lib/CMakeFiles/dummy_lib.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : libs/dummy_lib/CMakeFiles/dummy_lib.dir/depend

