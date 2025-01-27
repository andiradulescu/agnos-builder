#!/usr/bin/env bash
set -e

# Make sure we're in the correct spot
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
cd $DIR

BUILD_DIR="$DIR/build"
OUTPUT_DIR="$DIR/output"

ROOTFS_DIR="$BUILD_DIR/agnos-rootfs"
OUT_IMAGE="$OUTPUT_DIR/system.img"

# testing multiple compression methods

# xz - https://www.mankier.com/1/mksquashfs#Compressors_Available_and_Compressor_Specific_Options-xz
# takes forever to compress
# time mksquashfs $ROOTFS_DIR $OUT_IMAGE.xz -comp xz -Xbcj arm -b 1M -Xdict-size 100%

# gzip - https://www.mankier.com/1/mksquashfs#Compressors_Available_and_Compressor_Specific_Options-gzip_(default)
# 1m47.626s
# 1.1G    output/system.img.gz
# time mksquashfs $ROOTFS_DIR $OUT_IMAGE.gz -comp gzip

# lzo - https://www.mankier.com/1/mksquashfs#Compressors_Available_and_Compressor_Specific_Options-lzo
# 2m28.412s
# 1.2G    output/system.img.lzo
# ------  -----  -----  ----
# PON     1.5    1.5    10%
# XBL     2.4    3.9    16%
# ABL     3.7    7.6    25%
# kernel  3.48   11.07  24%
# weston  8.03   19.1   54%
# comma   -4.34  14.76  -29%
# onroad  ?      ?      -
# ------  -----  -----  ----
# time mksquashfs $ROOTFS_DIR $OUT_IMAGE.lzo -comp lzo -b 1M

# lz4 - https://www.mankier.com/1/mksquashfs#Compressors_Available_and_Compressor_Specific_Options-lz4
# 0m23.117s
# 1.6G    output/system.img.lz4
# time mksquashfs $ROOTFS_DIR $OUT_IMAGE.lz4 -comp lz4 -b 1M

# lz4hc - lz4 highest compression
# 2m19.943s
# 1.3G    output/system.img.lz4hc
# /usr/comma/tests/analyze-boot-time.py
# ------  -----  -----  ----
# PON     1.5    1.5    11%
# XBL     2.4    3.9    17%
# ABL     3.7    7.6    27%
# kernel  3.36   10.96  24%
# weston  6.89   17.85  50%
# comma   -3.95  13.9   -28%
# onroad  ?      ?      -
# ------  -----  -----  ----
# ------  -----  -----  ----
# PON     1.5    1.5    10%
# XBL     2.4    3.9    16%
# ABL     3.7    7.6    25%
# kernel  3.48   11.07  24%
# weston  7.46   18.54  51%
# comma   -3.89  14.65  -27%
# onroad  ?      ?      -
# ------  -----  -----  ----
# time mksquashfs $ROOTFS_DIR $OUT_IMAGE.lz4hc -comp lz4 -b 1M -Xhc

du -hs output/system.*
