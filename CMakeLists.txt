cmake_minimum_required(VERSION 3.13) #VERSION 3.13 IS REQUIRED FOR PICO-SDK
set(PICO_SDK_PATH ../../pico-sdk) #Set the path to the pico-sdk
include(pico_sdk_import.cmake) #Import sdk cmake file

project(rpi_m2OS C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

#TEST FILE
pico_sdk_init()
add_executable(test
        ./build/test/test.c
        )

pico_enable_stdio_usb(test 1)
pico_enable_stdio_uart(test 1)
pico_add_extra_outputs(test)
target_link_libraries(test pico_stdlib)

#HELLOWORLD FILE
add_executable(helloworld
        ./build/helloworld/helloworld.c
        )

pico_enable_stdio_usb(helloworld 1)
pico_enable_stdio_uart(helloworld 1)
pico_add_extra_outputs(helloworld)
target_link_libraries(helloworld pico_stdlib)
pico_add_extra_outputs(helloworld)
