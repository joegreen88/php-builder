#!/usr/bin/env bash

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"
php_src_dir="$this_dir/php-src"

# Usage: ./download.sh <version>
# This script downloads the php source from UK mirror to ./php-src/<version>/

if [ -z "$1" ]; then
    echo " !! Version ID is a required argument !! "
    exit
fi
version_id="$1"

extract_to="$php_src_dir/$version_id"
if [ -d "$extract_to" ]; then
    echo " !! Directory $extract_to already exists !! "
    exit
fi

download_link="http://uk1.php.net/get/php-$version_id.tar.gz/from/this/mirror"
save_to="$php_src_dir/tar/php-$version_id.tar.gz"
echo "Downloading from $download_link"
curl --location --output "$save_to" "$download_link"

echo "Downloaded $save_to, extracting to $extract_to/"
mkdir -p "$extract_to"
tar -xzvf "$save_to" --directory "$extract_to" --strip-components=1 &> /dev/null

echo "Source code for php-$version_id has been downloaded successfully."
