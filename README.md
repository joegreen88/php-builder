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

This would extract the source code to `./php-src/5.6.25`.

## Build PHP

Run `./build.sh <version>` to build the selected version of php.

For example, to build PHP 5.6.25 you would run `./build.sh 5.6.25`.

This would build to `./php-build/5.6.25`.

You could then verify the build by running `./php-build/5.6.25/bin/php --version`.

The php.ini would be loaded from `./php-conf/7.0.11/php.ini`.

## Activate PHP

Add the activate script to your shell in `.bash_profile` or `.bashrc` with `source /path/to/php-builder/activate.sh`.
You only need to do this once.

Now you can change the active php version at any time by calling `php-version <version>`.

For example, set the global php version to 5.6.25 with `php-version 5.6.25`.

## Clean

Run `./clean.sh <version>` to free up disk space by deleting the source code and tarball for the given php version.

Run `./clean.sh` without the version to delete all php sources and tarballs.

## Versions tested

 - 7.0.11 **✓**

## Why do it?

I've tried phpenv, it's unmaintained and I haven't had any joy with it.

I've also tried [php-build](https://php-build.github.io/), which worked well on my linux machine where I could
install updated packages with apt but I had problems with it on Mac OSX. I couldn't figure out how to pass
build parameters into the `./configure` command using this tool, which I needed to do to provide a custom openssl path
because homebrew wont let me link openssl (even with --force).

I want something easy to use, that performs well for my specific use case. I want to make it a little bit more
configurable in the future, so I can customise the build args for each version, and maybe give each version a custom
name.
