#!/bin/bash -e

echo "Installing openpilot dependencies"

# Install necessary libs
apt-fast update
apt-fast install --no-install-recommends -yq \
    autoconf \
    automake \
    build-essential \
    bzip2 \
    casync \
    clang \
    clinfo \
    cmake \
    cppcheck \
    curl \
    darkstat \
    dkms \
    gcc-arm-none-eabi \
    gpiod \
    libarchive-dev \
    libass-dev \
    libbz2-dev \
    libcurl4-openssl-dev \
    libczmq-dev \
    libdbus-1-dev \
    libeigen3-dev \
    libffi-dev \
    libfreetype6-dev \
    libglfw3-dev \
    libglib2.0-0t64 \
    libi2c-dev \
    libjpeg-dev \
    liblzma-dev \
    libomp-dev \
    libportaudio2 \
    libsdl2-dev \
    libsqlite3-dev \
    libssl-dev \
    libsystemd-dev \
    libtool \
    libusb-1.0-0-dev \
    libuv1-dev \
    libva-dev \
    libvdpau-dev \
    libvorbis-dev \
    libxcb-shm0-dev \
    libxcb-xfixes0-dev \
    libxcb1-dev \
    libzmq3-dev \
    libzstd-dev \
    locales \
    nethogs \
    ocl-icd-libopencl1 \
    ocl-icd-opencl-dev \
    opencl-headers \
    pkg-config \
    portaudio19-dev \
    texinfo \
    vnstat \
    wget \
    zlib1g-dev \
    zstd
