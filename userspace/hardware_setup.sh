#!/bin/bash -e

# Install driver deb files (we're fine with overwriting stuff too)
cd /tmp/agnos/debs
mkdir -p /usr/lib/aarch64-linux-gnu/libweston-8/
apt-get -o Dpkg::Options::="--force-overwrite" -f install -yq ./*.deb

# Install 16.04 version of libjson-c2
cd /tmp
wget http://ports.ubuntu.com/pool/main/j/json-c/libjson-c2_0.11-4ubuntu2.6_arm64.deb -O /tmp/libjson-c2_0.11-4ubuntu2.6_arm64.deb
apt install -yq /tmp/libjson-c2_0.11-4ubuntu2.6_arm64.deb

# Remove apt cache
rm -rf /var/lib/apt/lists/*

USERNAME=comma
adduser $USERNAME netdev
