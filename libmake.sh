#!/bin/bash
export PICO_SDK_PATH=/home/prrtchr/pico/pico-sdk

# Check if the argument is provided
if [ -z "$1" ]; then
    echo "Error: Please provide the filename as an argument."
    exit 1
fi

# Create the "objects" folder if it doesn't exist. Delete its contents.
mkdir -p objects
rm -rf objects/*

# Find .obj and .o files inside the specified folder path and copy them to the "objects" folder. #If the parent
if ! find ./build/CMakeFiles/"$1".dir/ -type f \( -name "*.obj" -o -name "*.o" \) -exec cp {} objects/ \; ; then
    echo "Error: No object files found or unable to copy files to the 'objects' folder."
    exit 1
fi

# Move to the "objects" folder
cd objects || exit 1

# Create the "include" folder if it doesn't exist
mkdir -p include

# Find header files for each .obj file and copy them to the "include" folder
for obj_file in *.obj; do
    # Get the base name of the object file
    base_name="${obj_file%.*.obj}"
    #echo $base_name
    # Find the corresponding header file and copy it to the "include" folder
    find $PICO_SDK_PATH -type f -name "$base_name.h" -exec cp {} include/ \;
done

# Move other header files to the "include" folder
#pico.h
find $PICO_SDK_PATH -type f -name "pico.h" -exec cp {} include/ \;
mkdir include/pico
find $PICO_SDK_PATH -type f -name "types.h" -exec cp {} include/pico \;
mv include/stdio.h include/pico/stdio.h
mv include/stdlib.h include/pico/stdlib.h
find $PICO_SDK_PATH -type f -name "version.h" -exec cp {} include/pico \;
mkdir include/mbedtls

find $PICO_SDK_PATH -type f -name "config.h" -exec cp {} include/mbedtls \;
find $PICO_SDK_PATH -type f -name "config.h" -exec cp {} include/pico \;

find $PICO_SDK_PATH -type f -name "check_config.h" -exec cp {} include/mbedtls \;
mv include/platform.h include/pico/platform.h
find $PICO_SDK_PATH -type f -name "platform_time.h" -exec cp {} include/mbedtls \;

find $PICO_SDK_PATH -type f -name "error.h" -exec cp {} include/pico \;
mv include/time.h include/pico/time.h

# Check if there are .o and .obj files
if ls *.o >/dev/null 2>&1 && ls *.obj >/dev/null 2>&1; then
  # Both .o and .obj files exist, create library with both
  if ! ar rcs libname.a *.o *.obj ; then
    echo "Error: Failed to create the library file."
    exit 1
  fi
elif ls *.o >/dev/null 2>&1; then
  # Only .o files exist, create library with .o files
  if ! ar rcs libname.a *.o ; then
    echo "Error: Failed to create the library file."
    exit 1
  fi
else
  # Only .obj files exist, create library with .obj files in the root folder of the script
  if ! ar rcs ../libname.a *.obj ; then
    echo "Error: Failed to create the library file."
    exit 1
  fi
fi

includepath=$(pwd)
echo "Library file 'libname.a' created successfully."
cd ..
path=$(pwd)

echo "Trying to build:"

# Set the compiler options
COMPILER="arm-none-eabi-g++"
CPU="-mcpu=cortex-m0plus"
THUMB="-mthumb"
OPTIMIZATION="-O3"
DEFINES="-DNDEBUG"

# Set the output file name
OUTPUT_FILE="${1%.*}.elf"

# Set the path to the Pico SDK headers and library
SDK_INCLUDE="-I$includepath/include"

# Compile the C source file
$COMPILER $CPU $THUMB $OPTIMIZATION $DEFINES $SDK_INCLUDE -o $OUTPUT_FILE $path/build/$1/$1.c $path/libname.a
