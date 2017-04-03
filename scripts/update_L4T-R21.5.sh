#!/bin/bash
#sudo apt-mark hold xserver-xorg-core
#sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
#sudo apt-get install --install-recommends linux-generic-lts-xenial xserver-xorg-core-lts-xenial xserver-xorg-lts-xenial xserver-xorg-video-all-lts-xenial xserver-xorg-input-all-lts-xenial libwayland-egl1-mesa-lts-xenial
#sudo apt-get install libusb-1.0-0-dev pkg-config
#./install_glfw3.sh
#mkdir build && cd build
#cmake ../ -DBUILD_EXAMPLES=true
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger
sudo apt-get install libssl-dev wget
./patch_realsense-ubuntu-L4T-R21.5.sh
sudo dmesg | tail -n 50
