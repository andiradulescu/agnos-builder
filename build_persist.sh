#!/bin/bash
set -e

# Make sure we're in the correct spot
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
cd $DIR

BUILD_DIR="$DIR/build_persist"

ROOTFS_DIR="$BUILD_DIR/persist-rootfs"
ROOTFS_IMAGE="$BUILD_DIR/persist.img.raw"
ROOTFS_IMAGE_SIZE=33554432

SPARSE_IMAGE="$BUILD_DIR/persist.img"
SKIP_CHUNKS_IMAGE="$BUILD_DIR/persist-skip-chunks.img"

# Temp
sudo umount -l $ROOTFS_DIR > /dev/null || true
sudo rm -rf $BUILD_DIR

# Create temp dir if non-existent
mkdir -p $BUILD_DIR

# Create filesystem ext4 image
echo "Creating empty filesystem"
fallocate -l $ROOTFS_IMAGE_SIZE $ROOTFS_IMAGE
mkfs.ext4 $ROOTFS_IMAGE > /dev/null

# Mount filesystem
echo "Mounting empty filesystem"
mkdir -p $ROOTFS_DIR
sudo umount -l $ROOTFS_DIR > /dev/null || true
sudo mount $ROOTFS_IMAGE $ROOTFS_DIR
sudo chown $(whoami):$(whoami) $ROOTFS_DIR/

mkdir -p $ROOTFS_DIR/comma
cd $ROOTFS_DIR/comma

# Generate new keys
echo y | ssh-keygen -t rsa -b 2048 -m PEM -f id_rsa -N ''
mv id_rsa.pub id_rsa.pub_alt
ssh-keygen -f id_rsa.pub_alt -e -m pkcs8 > id_rsa.pub
rm id_rsa.pub_alt

touch living-in-the-moment

sudo rm -rf $ROOTFS_DIR/lost+found

cd $DIR

# Unmount image
echo "Unmount filesystem"
sudo umount -l $ROOTFS_DIR

# Sparsify
echo "Sparsify image"
TMP_SPARSE="$(mktemp)"
img2simg $ROOTFS_IMAGE $TMP_SPARSE
mv $TMP_SPARSE $SPARSE_IMAGE

# Make image with skipped chunks
TMP_SKIP="$(mktemp)"
$DIR/tools/simg2dontcare.py $SPARSE_IMAGE $TMP_SKIP
mv $TMP_SKIP $SKIP_CHUNKS_IMAGE

echo "Done!"

