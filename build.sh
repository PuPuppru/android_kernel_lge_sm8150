#!/bin/sh
sudo rm -rf ./out
mkdir -p out
cd ./out
make clean && mrproper
cd ..
make clean && mrproper
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=../toolchain/gcc/bin/aarch64-linux-androidkernel-
make O=./out ARCH=arm64 vendor/alphalm_lao_com-perf_defconfig
make O=./out ARCH=arm64 REAL_CC=../toolchain/clang/bin/clang -j16
cp -f ./out/arch/arm64/boot/Image.gz-dtb ./packing/Image.gz-dtb
cd ./packing
./magiskboot split Image.gz-dtb
mv kernel_dtb dtb
./magiskboot dtb dtb patch
./magiskboot hexpatch ./kernel \
736B69705F696E697472616D667300 \
77616E745F696E697472616D667300
./magiskboot repack ./sample.img
