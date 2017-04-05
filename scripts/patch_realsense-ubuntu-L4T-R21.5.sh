#!/bin/bash -e

# Get the required tools and headers to build the kernel
sudo apt-get install build-essential git

if [ $(ls /dev/video* | wc -l) -ne 0 ];
then
	echo -e "\e[32m"
	read -p "First, remove all RealSense cameras attached. Hit any key when ready"
	echo -e "\e[0m"
fi

#Include usability functions
source ./scripts/patch-utils.sh

#Additional packages to build patch
require_package libusb-1.0-0-dev
require_package libssl-dev
require_package wget

LINUX_BRANCH=$(uname -r)
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Download the latest sources from NVidia
wget https://developer.nvidia.com/embedded/dlc/l4t-Jetson-TK1-Kernel-Sources-R21-5 -O ~/Downloads/kernel.tbz2
cd /usr/src/
sudo tar -jxvf ~/Downloads/kernel.tbz2
cd kernel/

patch -p1 < $DIR/realsense-camera-formats.patch

# Copy configuration
sudo cp /usr/src/linux-headers-$(uname -r)/.config .
sudo cp /usr/src/linux-headers-$(uname -r)/Module.symvers .

# Basic build so we can build just the uvcvideo module
#yes "" | make silentoldconfig modules_prepare
make scripts silentoldconfig modules_prepare

# Build the uvc, accel and gyro modules
KBASE=`pwd`
cd drivers/media/usb/uvc
sudo cp $KBASE/Module.symvers .
echo -e "\e[32mCompiling uvc module\e[0m"
sudo make -C $KBASE M=$KBASE/drivers/media/usb/uvc/ modules

# Copy the patched modules to a sane location
sudo cp $KBASE/drivers/media/usb/uvc/uvcvideo.ko ~/$LINUX_BRANCH-uvcvideo.ko

echo -e "\e[32mPatched kernel module created successfully\n\e[0m"

# Load the newly built module(s)
try_module_insert uvcvideo      ~/$LINUX_BRANCH-uvcvideo.ko /lib/modules/`uname -r`/kernel/drivers/media/usb/uvc/uvcvideo.ko

echo -e "\e[92m\n\e[1mScript has completed successfully. Please consult the installation guide for further instruction.\n\e[0m"
