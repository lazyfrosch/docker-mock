#!/bin/bash

docker run -it --rm \
    -e WORKDIR="$PWD" \
    -v "$HOME":"$HOME" \
    -v /data/cache/mock/build:/var/cache/mock \
    -v /data/cache/mock/cache:/var/lib/mock \
    --privileged \
    lazyfrosch/mock mock "$@"
