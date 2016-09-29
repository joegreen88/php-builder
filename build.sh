#!/usr/bin/env bash

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"
php_src_dir="$this_dir/php-src"

# Usage: ./php-build.sh <version> [ configure parameters ...]
# This script assumes that the php source is already downloaded to ./php-src/<version>/

if [ -z "$1" ]; then
    echo " !! Version ID is a required argument !! "
    exit
fi
version_id="$1"

version_dir="$php_src_dir/$version_id"
echo "Attempting to php-build php from $version_dir/"

if [ ! -d "$version_dir" ]; then
    echo " !! It's not a directory !! "
    exit
fi

build_dir="$this_dir/php-build/$version_id"
build_cmd="./configure --prefix=$build_dir \
    --enable-bcmath \
    --enable-mbstring \
    --enable-sockets \
    --enable-zip \
    --with-curl \
    --with-gd \
    --with-mysqli \
    --with-pear \
    --with-pdo-mysql \
    --with-openssl=/usr/local/opt/openssl"

#echo "$build_cmd"

cd "$version_dir"
$build_cmd
make
make install && echo "PHP successfully installed into $build_dir"
