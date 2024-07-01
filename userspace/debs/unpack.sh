#!/bin/bash -e

for deb in ./*.deb; do
    # Extract the base package name without version, architecture, and .deb extension
    base_pkg_name=$(basename "$deb" | sed -E 's/_.*//;s/\.deb$//')

    # Check if the file name contains 'arm64' or 'armhf' and append it to the folder name if it does
    if [[ "$deb" =~ arm64 ]]; then
        pkg_name="${base_pkg_name}_arm64"
    elif [[ "$deb" =~ armhf ]]; then
        pkg_name="${base_pkg_name}_armhf"
    else
        pkg_name="$base_pkg_name"
    fi

    echo "Unpacking $deb to $pkg_name"
    rm -rf "$pkg_name"
    dpkg-deb -R "$deb" "$pkg_name"
done
