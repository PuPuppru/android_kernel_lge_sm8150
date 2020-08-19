#!/bin/sh
rm -rf out
mkdir -p out
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=../pri/tools/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-androidkernel-
make O=./out ARCH=arm64 vendor/flashlmdd_lao_com-perf_defconfig
make O=./out ARCH=arm64 REAL_CC=/media/pupuppru/puo/sm8150/pri/tools/clang/host/linux-x86/clang-r349610/bin/clang -j12
cp -f ./out/arch/arm64/boot/Image.gz-dtb ./pri/tools/boot/Image.gz-dtb
