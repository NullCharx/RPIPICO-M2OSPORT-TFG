cmake_minimum_required(VERSION 3.13) #VERSION 3.13 IS REQUIRED FOR PICO-SDK
set(PICO_SDK_PATH ../../pico-sdk) #Set the path to the pico-sdk
include(pico_sdk_import.cmake) #Import sdk cmake file

project(rpi_m2OS C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

#add_subdirectory(libs/dummy_lib) #Add the dummy_lib directory

#dinamically add all the subdirectories in the lib folder.
#This is useful if you want to add a new library, you just need to add it in the lib folder and it will be automatically added to the project
#To work, each library must have a CMakeLists.txt file inside it, as well as any necessary file, such as .c and .h files.
#The compilation steps on each folder must also be configured in the CMakeLists.txt file of each library and be correct
# Create a list of directories inside the "lib" directory


#TEST FILE
pico_sdk_init()

#HELLOWORLD FILE
add_executable(helloworld
    ./build/helloworld/helloworld.c
)
# pull in common dependencies
target_link_libraries(helloworld pico_stdlib)
# enable usb output, disable uart output
pico_enable_stdio_usb(helloworld 1)
pico_enable_stdio_uart(helloworld 0)
# create map/bin/hex/uf2 file etc.
pico_add_extra_outputs(helloworld)



