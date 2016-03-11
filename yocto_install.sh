#!/bin/bash

echo "This script will install yocto layers at /home/cenk/yocto"
echo "Please make sure /home/cenk folder exists before launching this script !"

#Make working directory
mkdir -p /home/cenk/yocto

cd /home/cenk/yocto

#Clone different layers
git clone git://git.yoctoproject.org/poky
git clone git://github.com/linux4sam/meta-atmel.git
git clone git://git.openembedded.org/meta-openembedded

#Checkout the right commits
cd meta-atmel
git checkout a0d3498d3345939c8a00da9a99c169521b8bf5ff
cd ..

cd meta-openembedded
git checkout 721a2cabf352085d34dd14c22e71914d3429ca59
cd ..

cd poky
git checkout d9aabf9639510fdb3e2ccc21ba5ae4aa9f6e4a57
cd ..

#Patch meta-atmel layer
cd meta-atmel
wget https://raw.githubusercontent.com/oussemah/atmel_patches/master/0001-Updating-to-working-version-on-ariag25.patch
git apply 0001-Updating-to-working-version-on-ariag25.patch
cd ..

mkdir -p /home/cenk/yocto/download_src

cd poky
source oe-init-build-env build-atmel
cd build-atmel
rm -rf conf
wget https://github.com/oussemah/atmel_patches/raw/master/conf.tar.gz
tar -zxvf conf.tar.gz
cd ../..

#Done
echo "Yocto installation is done successfully !"

