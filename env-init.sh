#!/usr/bin/env bash

# shellcheck source=/dev/null
source env-template.sh

ENV_FILE=env.sh

# Write file, if not present:
if [ ! -f env.sh ]; then
    echo "$ENV_TEMPLATE" > $ENV_FILE
fi

# Evaluate, for if config file too old and is missing variables:
eval "$ENV_TEMPLATE"

# Load file:
# shellcheck source=/dev/null
source $ENV_FILE


function panic() {
    echo -e "$*"
    exit 1
}

if [ ! "$OUTPUT_DIR" ]; then
    if gitman help > /dev/null; then
        OUTPUT_DIR="$GITMAN_REPOS_LOCATION$OUTPUT_LN"
    else
        OUTPUT_DIR=~/Git/"$OUTPUT_LN"
    fi
fi

if [ ! -d "$OUTPUT_LN" ]; then
    echo "Creating symlink"
    ln -s "$OUTPUT_DIR" "$OUTPUT_LN"
fi

if [ ! -d "$OUTPUT_DIR" ]; then
    panic "Directory at '$OUTPUT_DIR' does not exist :( Aborting"
fi

