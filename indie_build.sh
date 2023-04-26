#!/usr/bin/env bash
#Indepentent build script for the pico-sdk (without resorting to cmake auto build)

filetoexecute=$1

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
export PICO_SDK_PATH=/home/prrtchr/pico/pico-sdk
#Preconfigure cmake (Generate objs)
cmake ..

#Check if the folder ./build/filetoexecute exists and save the path to save the .elf file
if [ -d "./$filetoexecute" ]; then
    echo "---->Build folder exists"
    cd ./$filetoexecute
    targetdir=$(pwd)

else
    echo "---->Build folder does not exist"
    mkdir $filetoexecute
    cd $filetoexecute
    targetdir=$(pwd)
fi
    cd ..

#Check if the cmake correctly generated the folder with the obj files
if [ -d "./CMakeFiles/$filetoexecute.dir" ]; then
    echo "---->Build folder exists"
    cd ./CMakeFiles/$filetoexecute.dir
else
    echo "---->Build folder does not exist"
    exit 0
fi

echo "manual build"
#/usr/bin/arm-none-eabi-gcc -mcpu=cortex-m0plus -mthumb -O3 -DNDEBUG -std=c11 -Wall -Wextra -Werror -I/home/prrtchr/pico/pico-sdk/src/rp2_common/ -I/home/prrtchr/pico/pico-sdk/src/common/pico_stdlib/include/ $filetoexecute.c -o $filetoexecute.elf
/usr/bin/arm-none-eabi-g++ -mcpu=cortex-m0plus -mthumb -O3 -DNDEBUG -Wl,--build-id=none --specs=nosys.specs -Wl,--wrap=sprintf -Wl,--wrap=snprintf -Wl,--wrap=vsnprintf -Wl,--wrap=__clzsi2 -Wl,--wrap=__clzdi2 -Wl,--wrap=__ctzsi2 -Wl,--wrap=__ctzdi2 -Wl,--wrap=__popcountsi2 -Wl,--wrap=__popcountdi2 -Wl,--wrap=__clz -Wl,--wrap=__clzl -Wl,--wrap=__clzll -Wl,--wrap=__aeabi_idiv -Wl,--wrap=__aeabi_idivmod -Wl,--wrap=__aeabi_ldivmod -Wl,--wrap=__aeabi_uidiv -Wl,--wrap=__aeabi_uidivmod -Wl,--wrap=__aeabi_uldivmod -Wl,--wrap=__aeabi_dadd -Wl,--wrap=__aeabi_ddiv -Wl,--wrap=__aeabi_dmul -Wl,--wrap=__aeabi_drsub -Wl,--wrap=__aeabi_dsub -Wl,--wrap=__aeabi_cdcmpeq -Wl,--wrap=__aeabi_cdrcmple -Wl,--wrap=__aeabi_cdcmple -Wl,--wrap=__aeabi_dcmpeq -Wl,--wrap=__aeabi_dcmplt -Wl,--wrap=__aeabi_dcmple -Wl,--wrap=__aeabi_dcmpge -Wl,--wrap=__aeabi_dcmpgt -Wl,--wrap=__aeabi_dcmpun -Wl,--wrap=__aeabi_i2d -Wl,--wrap=__aeabi_l2d -Wl,--wrap=__aeabi_ui2d -Wl,--wrap=__aeabi_ul2d -Wl,--wrap=__aeabi_d2iz -Wl,--wrap=__aeabi_d2lz -Wl,--wrap=__aeabi_d2uiz -Wl,--wrap=__aeabi_d2ulz -Wl,--wrap=__aeabi_d2f -Wl,--wrap=sqrt -Wl,--wrap=cos -Wl,--wrap=sin -Wl,--wrap=tan -Wl,--wrap=atan2 -Wl,--wrap=exp -Wl,--wrap=log -Wl,--wrap=ldexp -Wl,--wrap=copysign -Wl,--wrap=trunc -Wl,--wrap=floor -Wl,--wrap=ceil -Wl,--wrap=round -Wl,--wrap=sincos -Wl,--wrap=asin -Wl,--wrap=acos -Wl,--wrap=atan -Wl,--wrap=sinh -Wl,--wrap=cosh -Wl,--wrap=tanh -Wl,--wrap=asinh -Wl,--wrap=acosh -Wl,--wrap=atanh -Wl,--wrap=exp2 -Wl,--wrap=log2 -Wl,--wrap=exp10 -Wl,--wrap=log10 -Wl,--wrap=pow -Wl,--wrap=powint -Wl,--wrap=hypot -Wl,--wrap=cbrt -Wl,--wrap=fmod -Wl,--wrap=drem -Wl,--wrap=remainder -Wl,--wrap=remquo -Wl,--wrap=expm1 -Wl,--wrap=log1p -Wl,--wrap=fma -Wl,--wrap=__aeabi_lmul -Wl,--wrap=__aeabi_fadd -Wl,--wrap=__aeabi_fdiv -Wl,--wrap=__aeabi_fmul -Wl,--wrap=__aeabi_frsub -Wl,--wrap=__aeabi_fsub -Wl,--wrap=__aeabi_cfcmpeq -Wl,--wrap=__aeabi_cfrcmple -Wl,--wrap=__aeabi_cfcmple -Wl,--wrap=__aeabi_fcmpeq -Wl,--wrap=__aeabi_fcmplt -Wl,--wrap=__aeabi_fcmple -Wl,--wrap=__aeabi_fcmpge -Wl,--wrap=__aeabi_fcmpgt -Wl,--wrap=__aeabi_fcmpun -Wl,--wrap=__aeabi_i2f -Wl,--wrap=__aeabi_l2f -Wl,--wrap=__aeabi_ui2f -Wl,--wrap=__aeabi_ul2f -Wl,--wrap=__aeabi_f2iz -Wl,--wrap=__aeabi_f2lz -Wl,--wrap=__aeabi_f2uiz -Wl,--wrap=__aeabi_f2ulz -Wl,--wrap=__aeabi_f2d -Wl,--wrap=sqrtf -Wl,--wrap=cosf -Wl,--wrap=sinf -Wl,--wrap=tanf -Wl,--wrap=atan2f -Wl,--wrap=expf -Wl,--wrap=logf -Wl,--wrap=ldexpf -Wl,--wrap=copysignf -Wl,--wrap=truncf -Wl,--wrap=floorf -Wl,--wrap=ceilf -Wl,--wrap=roundf -Wl,--wrap=sincosf -Wl,--wrap=asinf -Wl,--wrap=acosf -Wl,--wrap=atanf -Wl,--wrap=sinhf -Wl,--wrap=coshf -Wl,--wrap=tanhf -Wl,--wrap=asinhf -Wl,--wrap=acoshf -Wl,--wrap=atanhf -Wl,--wrap=exp2f -Wl,--wrap=log2f -Wl,--wrap=exp10f -Wl,--wrap=log10f -Wl,--wrap=powf -Wl,--wrap=powintf -Wl,--wrap=hypotf -Wl,--wrap=cbrtf -Wl,--wrap=fmodf -Wl,--wrap=dremf -Wl,--wrap=remainderf -Wl,--wrap=remquof -Wl,--wrap=expm1f -Wl,--wrap=log1pf -Wl,--wrap=fmaf -Wl,--wrap=malloc -Wl,--wrap=calloc -Wl,--wrap=realloc -Wl,--wrap=free -Wl,--wrap=memcpy -Wl,--wrap=memset -Wl,--wrap=__aeabi_memcpy -Wl,--wrap=__aeabi_memset -Wl,--wrap=__aeabi_memcpy4 -Wl,--wrap=__aeabi_memset4 -Wl,--wrap=__aeabi_memcpy8 -Wl,--wrap=__aeabi_memset8 -Wl,-Map=$filetoexecute.elf.map -Wl,--script=/home/prrtchr/pico/pico-sdk/src/rp2_common/pico_standard_link/memmap_default.ld -Wl,-z,max-page-size=4096 -Wl,--gc-sections -Wl,--wrap=printf -Wl,--wrap=vprintf -Wl,--wrap=puts -Wl,--wrap=putchar -Wl,--wrap=getchar ./$filetoexecute/$filetoexecute.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_stdlib/stdlib.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_gpio/gpio.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_platform/platform.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_claim/claim.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_sync/sync.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_irq/irq.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_irq/irq_handler_chain.S.obj ./home/prrtchr/pico/pico-sdk/src/common/pico_sync/sem.c.obj ./home/prrtchr/pico/pico-sdk/src/common/pico_sync/lock_core.c.obj ./home/prrtchr/pico/pico-sdk/src/common/pico_sync/mutex.c.obj ./home/prrtchr/pico/pico-sdk/src/common/pico_sync/critical_section.c.obj ./home/prrtchr/pico/pico-sdk/src/common/pico_time/time.c.obj ./home/prrtchr/pico/pico-sdk/src/common/pico_time/timeout_helper.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_timer/timer.c.obj ./home/prrtchr/pico/pico-sdk/src/common/pico_util/datetime.c.obj ./home/prrtchr/pico/pico-sdk/src/common/pico_util/pheap.c.obj ./home/prrtchr/pico/pico-sdk/src/common/pico_util/queue.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_uart/uart.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_clocks/clocks.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_pll/pll.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_vreg/vreg.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_watchdog/watchdog.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_xosc/xosc.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/hardware_divider/divider.S.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_runtime/runtime.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_printf/printf.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_bit_ops/bit_ops_aeabi.S.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_bootrom/bootrom.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_divider/divider.S.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_double/double_aeabi.S.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_double/double_init_rom.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_double/double_math.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_double/double_v1_rom_shim.S.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_int64_ops/pico_int64_ops_aeabi.S.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_float/float_aeabi.S.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_float/float_init_rom.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_float/float_math.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_float/float_v1_rom_shim.S.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_malloc/pico_malloc.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_mem_ops/mem_ops_aeabi.S.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_standard_link/crt0.S.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_standard_link/new_delete.cpp.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_standard_link/binary_info.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_stdio/stdio.c.obj ./home/prrtchr/pico/pico-sdk/src/rp2_common/pico_stdio_uart/stdio_uart.c.obj -o $targetdir/$filetoexecute.elf /home/prrtchr/pico/RPIPICO-M2OSPORT-TFG/build/pico-sdk/src/rp2_common/boot_stage2/bs2_default_padded_checksummed.S
#Generate .uf2 file the binary is located in the build directory (two steps up from the current directory)
echo "generating .elf file from .uf2 file"
../../elf2uf2/elf2uf2 $targetdir/$filetoexecute.elf $targetdir/$filetoexecute.uf2

echo "---->Detecting mounted RPIPico"
#Check if rpipico is mounted

if [ -d "/media/$(whoami)/RPI-RP2" ]; then
    echo "---->RPI-RP2 mounted. Attempting to copy file"
    cd "$targetdir"
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
        #Connect to the RPIPico using minicom sudo needed!
        sudo minicom -b 115200 -o -D /dev/ttyACM0
    elif [ "$debugtype" = "2" ] || [ "$debugtype" = "JS" ] || [ "$debugtype" = "js" ]; then
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