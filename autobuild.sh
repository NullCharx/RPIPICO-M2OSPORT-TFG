#!/usr/bin/env bash

filetoexecute=$1
usbdebug=$2
export PICO_SDK_PATH=/home/prrtchr/pico/pico-sdk

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
make -j6

echo "---->Project built"

echo "---->moving generated files to the build subdirectory"
#For each .bin, .dis, .elf, .hex, .uf2 and .elf.map file in build directory, move it to the directory of the same name without the extension
#This can be changed later.
for file in *.bin *.dis *.elf *.hex *.uf2 *.elf.map; do
    if [ -f "$file" ]; then
        mv "$file" "${file%.*}"
    fi
done

rm *.uf2 2> /dev/null
rm *.bin 2> /dev/null
rm *.dis 2> /dev/null
rm *.elf 2> /dev/null
rm *.hex 2> /dev/null
rm *.elf.map 2> /dev/null

#Check if the user inserted a file to execute
if [ -z "$filetoexecute" ]; then
    echo "---->No file to execute. Build finished"
    exit 1
fi

echo "---->Detecting mounted RPIPico"
#Check if rpipico is mounted

if [ -d "/media/$(whoami)/RPI-RP2" ]; then
    echo "---->RPI-RP2 mounted. Attempting to copy file"
    cd "$filetoexecute"
    pwd
    #Copy the file to the mounted drive
    sudo cp "${filetoexecute}.uf2" "/media/$(whoami)/RPI-RP2/${filetoexecute}.uf2"
    sudo sync
    echo "---->File: $filetoexecute copied to RPIPico. Build finished"
    #Check if the user wants to debug, wether it is that the user entered a second argument with a 1 or true or othewise put 0, false or didnt add a second
    #argument
    if [ "$usbdebug" = "0" ] || [ "$usbdebug" = "false" ] || [ -z "$usbdebug" ]; then
        echo "---->Debugging disabled. Build finished"
    elif [ "$usbdebug" = "1" ] || [ "$usbdebug" = "true" ]; then
        echo "---->Debugging enabled. Attempting to connect to RPIPico"
        #Connect to the RPIPico using minicom sudo needed!
        sudo minicom -b 115200 -o -D /dev/ttyACM0
    else
        echo "---->Unrecognized argument. Debugging disabled. Build finished"
    fi
    echo "Execution finished"
    exit 1


else
    echo "---->RPIPico not mounted. Build finished"
    exit 1
fi
