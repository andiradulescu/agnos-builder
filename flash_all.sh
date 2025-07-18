#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
cd $DIR

for part in aop xbl xbl_config devcfg; do
  tools/edl w ${part}_a $DIR/output/$part.img
  tools/edl w ${part}_b $DIR/output/$part.img
done

./flash_bootloader.sh
./flash_kernel.sh
./flash_system.sh
