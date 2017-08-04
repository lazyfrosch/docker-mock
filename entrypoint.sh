#!/bin/bash

set -e

if [ "$1" = mock ] || [ "$1" = /usr/bin/mock ]; then
    if [ `stat -c %G /var/lib/mock` != mock ]; then
        echo "Updating permissions on /var/lib/mock"
        chgrp -R mock /var/lib/mock
        find /var/lib/mock -type d -exec chmod g+s {} \;
    fi

    if [ `stat -c %G /var/cache/mock` != mock ]; then
        echo "Updating permissions on /var/cache/mock"
        chgrp -R mock /var/cache/mock
        find /var/cache/mock -type d -exec chmod g+s {} \;
    fi

    if [ -n "$WORKDIR" ] && [ -d "$WORKDIR" ]; then
        cd "$WORKDIR"
    fi

    exec gosu "$USER" "$@"
else
    exec "$@"
fi
