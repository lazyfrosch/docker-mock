#!/bin/bash

set -e

TARGET="$1"
shift
SPECS=($(ls *.spec))
INSTALL_PKGS=()

if [ -z "$TARGET" ]; then
    echo "You need to specify target!" >&2
    false
fi

while [ -n "$1" ]; do
    case "$1" in
        --install)
            shift
            INSTALL_PKGS+=("$1")
            ;;
        *)
            echo "Unknown cmd line option: $1" >&2
            exit 1;
            ;;
    esac
    shift
done

count=${#SPECS[@]}
if [ "$count" -eq 0 ]; then
    echo "No spec found!" >&2
    false
elif [ "$count" -gt 1 ]; then
    echo "Found more than one spec file: ${SPECS[@]}" >&2
    false
fi

spec="${SPECS[0]}"

set -x

if [ -d result/ ]; then
    rm -f result/*.log result/*.rpm
fi

mock -r "$TARGET" --resultdir result/ --buildsrpm --spec "$spec" --sources . "$@"

srpm="$(tail -n 5 result/build.log | grep -F Wrote: | cut -d" " -f2-)"
srpm="$(basename "$srpm")"

if [ -z "$srpm" ]; then
    echo "Could not find a src.rpm in build log!" >&2; false
elif [ ! -f result/"$srpm" ]; then
    echo "Could not find '$srpm' in result/ dir!" >&2; false
fi

if [ "${#INSTALL_PKGS[@]}" -gt 0 ]; then
    # install packages
    mock -r "$TARGET" --no-clean --install "${INSTALL_PKGS[@]}"
fi

mock -r "$TARGET" --no-clean --resultdir result/ --rebuild result/"$srpm" "$@"
