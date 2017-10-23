#!/bin/bash

set -e

: ${USER:=build}
: ${UID:=1000}
: ${GROUP:=build}
: ${GID:=100}

export USER UID GROUP GID

if [ "$1" = mock ] || [ "$1" = /usr/bin/mock ]; then
    echo "Working as user $USER ($UID)"
    groupadd -g "$GID" "$GROUP"
    useradd -g "$GROUP" -G mock -u "$UID" "$USER"

    if [ `stat -c %G /var/lib/mock` != mock ]; then
        echo "Updating permissions on /var/lib/mock"
        chgrp mock /var/lib/mock
        chmod g+s /var/cache/mock
    fi

    if [ `stat -c %G /var/cache/mock` != mock ]; then
        echo "Updating permissions on /var/cache/mock"
        chgrp mock /var/cache/mock
        chmod g+s /var/cache/mock
    fi

    if [ -n "$WORKDIR" ] && [ -d "$WORKDIR" ]; then
        cd "$WORKDIR"
    fi

    exec gosu "$USER" "$@"
else
    exec "$@"
fi
