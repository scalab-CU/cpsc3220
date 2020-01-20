#!/bin/bash

cd

# dowanload and install riscv64 gcc toolchain
wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz
tar xfz riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz
mv riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14 gnu

# setshell environment variables
echo "cpsc3200(){" >> ~/.bashrc
echo "   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/qemu/lib:$HOME/gnu/lib" >> ~/.bashrc
echo "   export PATH=$PATH:$HOME/qemu/bin:$HOME/gnu/bin" >> ~/.bashrc
echo "}" >> ~/.bashrc
echo "cpsc3200" >> ~/.bashrc

source ~/.bashrc

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/qemu/lib:$HOME/gnu/lib
export PATH=$PATH:$HOME/qemu/bin:$HOME/gnu/bin

# download and install qemu
wget https://download.qemu.org/qemu-4.2.0.tar.xz
tar xf qemu-4.2.0.tar.xz
cd qemu-4.2.0
./configure --disable-kvm --disable-werror --prefix=$HOME/qemu --target-list="riscv64-softmmu"
make
make install
cd

# Verify if the installation succeeds
riscv64-unknown-elf-gcc --version
qemu-system-riscv64 --version

