#!/usr/bin/env bash

OUTPUT_LN=nirokay.com

function panic() {
    echo -e "$*"
    exit 1
}

OUTPUT_DIR="" # Enter here, if you want to override the repo location
if [ ! "$OUTPUT_DIR" ]; then
    if gitman help > /dev/null; then
        OUTPUT_DIR="$GITMAN_REPOS_LOCATION$OUTPUT_LN"
    else
        OUTPUT_DIR=~/Git/$OUTPUT_LN
    fi
fi

if [ ! -d "$OUTPUT_DIR" ]; then
    panic "Directory at '$OUTPUT_DIR' does not exist :( Aborting"
fi

if [ ! -d $OUTPUT_LN ]; then
    echo "Creating symlink"
    ln -s "$OUTPUT_DIR" $OUTPUT_LN
fi
