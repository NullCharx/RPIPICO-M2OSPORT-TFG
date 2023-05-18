#!/usr/bin/env bash
filetoexecute=$1
debugtype=$2
export PICO_SDK_PATH=/home/prrtchr/pico/pico-sdk

echo "Autobuild.sh but it doesnt have rpipico mounting capabilities"


echo "---------------->REGENERATING ALL FILES<-------------------"

#Check if folder build exists in current directory
if [ -d "build" ]; then
    echo "---->Build folder exists"
else
    echo "---->Build folder does not exist"
    mkdir build
fi
#Change to build directory
cd build
#Export path to pico-sdk (absolute path)
#Preconfigure cmake and make
cmake ..
make -j6 -n

echo "---->Project built"


echo "-----------> Deleting files (if they exist) in the build subdirectory"
rm *.uf2 2> /dev/null
rm *.bin 2> /dev/null
rm *.dis 2> /dev/null
rm *.elf 2> /dev/null
rm *.elf.map 2> /dev/null
rm *.hex 2> /dev/null

echo "---------------->FILE REGENERATION DONE<-------------------"

