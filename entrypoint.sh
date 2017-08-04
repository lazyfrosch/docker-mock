#!/bin/bash

set -e

if [ "$1" = mock ] || [ "$1" = /usr/bin/mock ]; then
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
