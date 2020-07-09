#!/bin/sh
sudo rm -rf out
mkdir -p out
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=../pri/tools/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-androidkernel-
make O=./out ARCH=arm64 vendor/flashlmdd_lao_com-perf_defconfig
make O=./out ARCH=arm64 REAL_CC=../pri/tools/clang/host/linux-x86/clang-r349610/bin/clang -j12
cp -f ./out/arch/arm64/boot/Image.gz-dtb ./pri/tools/boot/Image.gz-dtb
cd ./pri/tools/boot
./magiskboot split Image.gz-dtb
mv kernel_dtb dtb
./magiskboot dtb dtb patch
./magiskboot hexpatch ./kernel \
736B69705F696E697472616D667300 \
77616E745F696E697472616D667300
./magiskboot repack ./boot_a.img
