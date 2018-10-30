#!/usr/bin/env bash

# Set up by sourcing in your .bash_profile or similar.

php-version() {

    this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"
    php_build_dir="$this_dir/php-build"

    # Usage: php-version <version>
    # This script assumes that the php version is already built in ./php-build/<version>
    
    case "$1" in
        list|ls|--list)
            ls "$php_build_dir"
            return 0
            ;;
        *)
    esac
    
    if [ -z "$1" ]; then
        php_executable_path="$(command -v php)"
        echo "Active: $php_executable_path"
        echo "Available:"
        ls "$php_build_dir"
        return 0
    fi
    version_id="$1"

    version_dir="$php_build_dir/$version_id"
    echo "Activating php living at $version_dir/"

    bin_dir="$version_dir/bin"

    if [ -x "$bin_dir/php" ]; then
        PATH="$bin_dir:$PATH"
        # Trim duplicate entries from PATH (see: https://sites.google.com/site/jdisnard/path-dupes)
        PATH=`awk -F: '{for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); }}' <<< $PATH`
        echo "PHP version $version_id is active."
    else
        echo " !! $bin_dir/php must exist and be executable !! "
        return 1
    fi

}
