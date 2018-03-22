#!/usr/bin/env bash

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"
php_src_dir="$this_dir/php-src"

# Detect what OS type is it.
os="$(uname -s)"

# Usage: ./build.sh <version>
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
if [ -d "$build_dir" ]; then
    echo " !! $build_dir already exists; please remove it if you want to rebuild !! "
    exit
fi

ini_dir="$this_dir/php-conf/$version_id"
if ! [ -d "$ini_dir" ]; then
    mkdir -p "$ini_dir"
fi
if ! [ -e "$ini_dir/php.ini" ]; then
    echo "Copying php.ini-development to $ini_dir/php.ini"
    cp "$version_dir/php.ini-development" "$ini_dir/php.ini"
    chmod 644 "$ini_dir/php.ini"
fi

if [ "$os" == "Darwin" ]; then
    build_cmd="./configure --prefix=$build_dir \
        --enable-bcmath \
        --enable-mbstring \
        --enable-pcntl \
        --enable-sockets \
        --enable-zip \
        --with-curl \
        --with-gd \
        --with-mysqli \
        --with-pear \
        --with-pdo-mysql \
        --with-openssl=/usr/local/opt/openssl \
        --with-config-file-path=$ini_dir"
elif [ "$os" == "Linux" ]; then
    build_cmd="./configure --prefix=$build_dir \
        --enable-bcmath \
        --enable-mbstring \
        --enable-pcntl \
        --enable-sockets \
        --enable-zip \
        --with-curl \
        --with-gd \
        --with-mysqli \
        --with-pear \
        --with-pdo-mysql \
        --with-config-file-path=$ini_dir"
fi

# add custom buildargs from buildargs directory
# e.g. if building php 7.2.12 then look for files called 7, 7.2, and 7.2.12 in that order

version_id_major=${version_id%%.*}
version_id_minor=${version_id%.*}

customBuildArgs=""

for arg_file_var in version_id_major version_id_minor version_id; do
    eval arg_file="\$$arg_file_var"
    arg_file_path="$this_dir/buildargs/$arg_file"
    if [ -s "$arg_file_path" ] && [ -r "$arg_file_path" ]; then
        echo "Fetching custom build arguments from $arg_file_path"
        if [ -z "$customBuildArgs" ]; then
            customBuildArgs=$(cat "$arg_file_path")
        else
            customBuildArgs="$customBuildArgs $(cat "$arg_file_path")"
        fi
    fi
done

if [ ! -z "$customBuildArgs" ]; then
    echo "Applying custom build arguments: $customBuildArgs"
    build_cmd="$build_cmd $customBuildArgs"
fi

#echo "$build_cmd"

# Run the php build
cd "$version_dir"
$build_cmd
make clean
make
make install && echo "PHP successfully installed into $build_dir"
