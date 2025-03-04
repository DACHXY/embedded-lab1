# Lab1

學號:   410530042  
姓名:   張辰瑋  
Email:  <WCDanny1013@gmail.com>  

---

## 實驗名稱

Cross Toolchain for Raspberry Pi

## 實驗目的

Cross build Linux kernel 至 `arm-linux-gnueabihf` 目標機器

## 實驗步驟

### Prerequisites and Build Cross Toolchain From Source Codes

1. 安裝 Linux 系統
    - 已安裝 NixOS

2. 下載 source code
    - `gcc 12.3.0`
    - `binutils 2.40`
    - `GLIBC 2.38`
    - `Linux kernel (Raspberry pi)`

### Build cross `binutils`

```bash
mkdir build_binutils && cd build_binutils

../binutils-2.40/configure \
--prefix=/home/danny/projects/embedded-lab1/crossgcc1 \
--target=arm-linux-gnueabihf

make
make install
```

### Build a bare-metal cross compiler

```bash
mkdir build_gcc && cd build_gcc

CFLAGS="-Wno-error=format-security" \
CXXFLAGS="-Wno-error=format-security" \
../gcc-12.3.0/configure \
--prefix=/home/danny/projects/embedded-lab1/crossgcc1 \
--target=arm-linux-gnueabihf \
--enable-languages=c --without-headers \
--disable-libmudflap --disable-libatomic \
--with-arch=armv6 --disable-shared \
--enable-static --disable-decimal-float \
--disable-libgomp --disable-libitm \
--disable-libssp --disable-threads \
--with-float=hard --with-fpu=vfp

make
make install
```

### Install Kernel Headers

```bash
cd linux
make headers_install ARCH=arm \
INSTALL_HDR_PATH=/home/danny/projects/embedded-lab1/sysroot/usr
```

### Build GLIBC

```bash
mkdir build_glibc && cd build_glibc

../glibc-2.38/configure --prefix=/usr \
--host=arm-linux-gnueabihf \
--target=arm-linux-gnueabihf \
--with-headers=/home/danny/projects/embedded-lab1/sysroot/usr/include \
--includedir=/usr/include \
CXX=arm-linux-gnueabihf-g++

make
make install install_root=/home/danny/projects/embedded-lab1/sysroot
```

### Build Cross Binutils

```bash
mkdir build_binutils2 && cd build_binutils2

../binutils-2.40/configure \
--prefix="/home/danny/projects/embedded-lab1/crossgcc2" \
--target=arm-linux-gnueabihf \
--with-sysroot=/home/danny/projects/embedded-lab1/sysroot

make
make install

```

### Build a Cross Compiler

```bash
mkdir build_gcc2 && cd build_gcc2

CFLAGS="-Wno-error=format-security" \
CXXFLAGS="-Wno-error=format-security" \
../gcc-12.3.0/configure \
--prefix=/home/danny/projects/embedded-lab1/crossgcc2 \
--target=arm-linux-gnueabihf \
--with-sysroot=/home/danny/projects/embedded-lab1/sysroot \
--enable-languages=c \
--with-arch=armv6 --with-fpu=vfp --with-float=hard \
--disable-libmudflap --enable-libgomp \
--disable-libssp --enable-libquadmath \
--enable-libquadmath-support \
--disable-libsanitizer --enable-lto \
--enable-threads=posix --enable-target-optspace \
--with-linker-hash-style=gnu --disable-nls \
--disable-multilib --enable-long-long

make
make install
```

## 問題與討論

### Q: 請說明參數 "`--with-sysroot`" 的目的爲何?

使用 `--with-sysroot` 可以指定使用之前編譯的 arm 架構的 Linux header files 與 Glibc header files,
這樣避免編譯器使用 Host OS 的 header files, 編譯出指定架構的 binary 檔案
