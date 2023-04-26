#!/usr/bin/env bash

filetoexecute=$1
debugtype=$2
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
make -j6 --trace

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
    #Check what kind of debugging the user wants. If the user wants to use usb debugging, by putting "USB" or 1 then connect to the RPIPico using minicom
    #If the user wants to use javascript debugging, by putting "JS" or 2 then copy the .hex to the rp2040js foldder and run npm install and npm start
    #I the user puts 0, "none", nothing or anything else then dont debug

    if [ "$debugtype" = "0" ] || [ "$debugtype" = "none" ] || [ -z "$debugtype" ]; then
        echo "---->Debugging disabled. Build finished"
    elif [ "$debugtype" = "1" ] || [ "$debugtype" = "USB" ] || [ "$debugtype" = "usb" ]; then
        echo "---->Debugging enabled. Attempting to connect to RPIPico"
        #Connect to the RPIPico using minicom sudo needed! (Or add user to the dialout group)
        sudo minicom -b 115200 -o -D /dev/ttyACM0
    elif [ "$debugtype" = "2" ]  || [ "$debugtype" = "JS" ] || [ "$debugtype" = "js" ]; then
        echo "---->Debugging enabled. Attempting to debug via javascript debugger"
        #Copy the .hex file to the rp2040js folder
        cp "${filetoexecute}.hex" "/home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/rp2040js/${filetoexecute}.hex"
        echo "---->File copied to rp2040js folder. Attempting to launch server"
        #Change to the rp2040js folder
        cd /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/rp2040js/
        #Install the dependencies
        npm install
        #Start the server
        npm start
    else
        echo "---->Unrecognized argument. Debugging disabled. Build finished"
    fi

    #The same as above but for javascript debugging
    echo "Execution finished"
    exit 1


else
    echo "---->RPIPico not mounted. Build finished"
    exit 1
fi
