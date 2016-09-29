php-builder
===========

The aim of this repo is to make it a bit easier to build php from source.

I've developed and tested these scripts on OSX el capitan with homebrew installed.

## Setup

If you are on OSX run `./setup-osx.sh`. 

This script will install some dependencies using homebrew (openssl for example).

## Download PHP

Run `./download.sh <version>` to download and extract the php source code. 

For example, to download PHP 5.6.25 you would run `./download.sh 5.6.25`.

This would extract the source code to './php-src/5.6.25'.

## Build PHP

Run `./build.sh <version>` to build the selected version of php.

For example, to build PHP 5.6.25 you would run `./build.sh 5.6.25`.

This would build to `./php-build/5.6.25`.

## Clean

Run `./clean.sh <version>` to free up disk space by deleting the source code and tarball for the given version.

Run `./clean.sh` without the version to delete all php sources and tarballs.

## Versions tested