#!/bin/bash
export PICO_SDK_PATH=/home/prrtchr/pico/pico-sdk/

# Check if the argument is provided
if [ -z "$1" ]; then
    echo "Error: Please provide the filename as an argument."
    exit 1
fi

echo "--------Regenerating project files (autobuild.sh)"
./fileregen.sh
echo "--------Project files regenerated."


echo "---------Reading link file for $1 program:"
content=$(cat "/home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/CMakeFiles/$1.dir/link.txt")

echo "Content of link file:"
echo "$content"
echo "---------Done"



echo "---------Extracting the objs paths"

# Use regular expression to extract the list of object files
obj_files=$(echo "$content" | grep -oE '[^ ]+\.obj')

# Print the list of object files
echo "Detected objs list: $obj_files"

echo "reformatting to make it linker friendly"
# Replace newlines with spaces
obj_files=$(echo "$obj_files" | tr '\n' ' ')

echo "---------Done"

echo "---------Extracting the link flags"
# Use regular expression to extract the list of object files
wlflags=$(echo "$content" | grep -oE '\-Wl[^ ]+|--specs=nosys.specs')

# Print the list of object files
echo "Detected flag list: $obj_files"

echo "reformatting to make it linker friendly"
# Replace newlines with spaces
wlflags=$(echo "$wlflags" | tr '\n' ' ')

echo "---------Done"


echo "---------Generating static library"
ar rcs libname.a $obj_files
echo "---------Done"


echo "Generating link command"
# Set the compiler options
COMPILER="arm-none-eabi-g++"
CPU="-mcpu=cortex-m0plus"
THUMB="-mthumb"
OPTIMIZATION="-O3"
FLAGS="-DNDEBUG $wlflags"
OUTPUT_FILE="-o $1.elf"
LIBRARY "-llibname"
CHECKSUMMER="/home/prrtchr/pico/pico-examples/build/pico-sdk/src/rp2_common/boot_stage2/bs2_default_padded_checksummed.S"

echo "command: $COMPILER $CPU $THUMB $OPTIMIZATION $FLAGS $OUTPUT_FILE $LIBRARY $CHECKSUMMER"

if ! $COMPILER $CPU $THUMB $OPTIMIZATION $FLAGS $OUTPUT_FILE $LIBRARY $CHECKSUMMER; then
    echo "Error: Compilation failed."
    exit 1
fi

echo "Build successful. Output file: $OUTPUT_FILE"


echo "generating u2f2 file"
currentpath=$(pwd)
build/elf2uf2/elf2uf2 $currentpath/$1.elf $currentpath/$1.uf2
echo "Done"

filetoexecute="$1.uf2"
echo "attempting to copy file to RPIPico"
if [ -d "/media/$(whoami)/RPI-RP2" ]; then
    #Copy the file to the mounted drive
    sudo cp "${filetoexecute}" "/media/$(whoami)/RPI-RP2/${filetoexecute}.uf2"
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
        sudo -S minicom -b 115200 -o -D /dev/ttyACM0
        echo ' if minicom didnt work, try "sudo minicom -b 115200 -o -D /dev/ttyACM0" after this script finishes'
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
