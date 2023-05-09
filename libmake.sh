#!/bin/bash

# Check if the argument is provided
if [ -z "$1" ]; then
    echo "Error: Please provide the filename as an argument."
    exit 1
fi

# Create the "objects" folder if it doesn't exist
mkdir -p objects

# Find .obj and .o files inside the specified folder path and copy them to the "objects" folder
if ! find ./build/CMakeFiles/"$1".dir/ -type f \( -name "*.obj" -o -name "*.o" \) -exec cp {} objects/ \; ; then
    echo "Error: No object files found or unable to copy files to the 'objects' folder."
    exit 1
fi

# Move to the "objects" folder
cd objects || exit 1

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
  # Only .obj files exist, create library with .obj files
  if ! ar rcs libname.a *.obj ; then
    echo "Error: Failed to create the library file."
    exit 1
  fi
fi

echo "Library file 'libname.a' created successfully."
