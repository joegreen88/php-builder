#!/usr/bin/env bash

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Usage: ./clean.sh [<version>]
# This script deletes the contents of the php-src folder to free up disk space.

if [ -z "$1" ]; then
    echo "Cleaning the php-src directory"
    rm -rf "$this_dir/php-src"
    mkdir -p "$this_dir/php-src/tar"
else
    version_id="$1"
    echo "Removing the source files and/or tarball for version $version_id"
    rm -rf "$this_dir/php-src/$version_id"
    rm -rf "$this_dir/php-src/tar/php-$version_id.tar.gz"
fi
