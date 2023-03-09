#!/usr/bin/env bash

#!/usr/bin/env bash

filetoexecute=$1
#Check if fodler build exists in current directory
if [ -d "build" ]; then
    echo "---->Build folder exists"
else
    echo "---->Build folder does not exist"
    mkdir build
fi
#Change to build directory
cd build
#Export path to pico-sdk (absolute path)
export PICO_SDK_PATH=/home/prrtchr/pico/pico-sdk
#Preconfigure cmake and make
cmake ..
make -j6

echo "---->File $filetoexecute built"

#Check if the user inserted a file to execute
if [ -z "$filetoexecute" ]; then
    echo "---->No file to execute. Build finished"
    exit 1
fi
echo "---->Detecting mounted RPIPico"
#Check if rpipico is mounted
if [ -d "/media/$(whoami)/RPI-RP2" ]; then
    echo "---->RPI-RP2 mounted. Attempting to copy file"
    #Copy the file to the mounted drive
    sudo cp ./"$filetoexecute".uf2 /media/$(whoami)/RPI-RP2/"$filetoexecute".uf2
    sudo sync
    sudo umount /media/$(whoami)/RPI-RP2
    echo "---->File: $filetoexecute copied to RPIPico. Build finished"
    exit 1
else
    echo "---->RPIPico not mounted. Build finished"
    exit 1
fi

