php-builder
===========

The aim of this repo is to make it a bit easier to build php from source.

I've developed and tested these scripts on OSX el capitan with homebrew installed and Ubuntu 16.04.

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

### Build Arguments

You can add arguments to the php build via config files.
This method can be used to compile with additional extensions.

For example, to enable the sysvsem extension on all new PHP 7 builds,
create a file called `7` in the *buildargs* directory with the following contents:

    --enable-sysvsem

You can add multiple build arguments as if you were using them on the command line, like so:

    --enable-sysvsem --enable-sysvshm --enable-sysvmsg

You can also choose to apply build arguments to a specific minor version or patch if you want to. 

For example, to install exif extension for new PHP 7.0.11 builds only,
create a file called `7.0.11` in the *buildargs* directory with the following contents:

    --enable-exif

Remember to build PHP after the configuration files are in place for the build arguments to take effect.

## Activate PHP

Add the activate script to your shell in `.bash_profile` or `.bashrc` with `source /path/to/php-builder/activate.sh`.
You only need to do this once.

Now you can change the active php version at any time by calling `php-version <version>`.

For example, set the global php version to 5.6.25 with `php-version 5.6.25`.

You can check which PHP versions are installed with php-builder by running `php-version list`.

You can check the active PHP version by running `php --version`.

## Clean

Run `./clean.sh <version>` to free up disk space by deleting the source code and tarball for the given php version.

Run `./clean.sh` without the version to delete all php sources and tarballs.

## Versions tested

 - 7.0.11 **✓**
 - 7.1.3 **✓**

## Why do it?

I've tried phpenv, it's unmaintained and I haven't had any joy with it.

I've also tried [php-build](https://php-build.github.io/), which worked well on my linux machine where I could
install updated packages with apt but I had problems with it on Mac OSX. I couldn't figure out how to pass
build parameters into the `./configure` command using this tool, which I needed to do to provide a custom openssl path
because homebrew wont let me link openssl (even with --force).

I want something easy to use, that performs well for my specific use case. I want to make it a little bit more
configurable in the future, so I can customise the build args for each version, and maybe give each version a custom
name.
