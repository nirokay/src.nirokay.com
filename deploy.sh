#!/usr/bin/env bash

# shellcheck source=/dev/null
source ./env.sh

./compile-typescript.sh || {
    echo -e "Failed to compile TS"
    exit 1
}
nimble build || {
    echo -e "Failed to compile Nim code"
    exit 1
}
nimble run || {
    echo -e "Failed to run Nim code"
    exit 1
}

cd "$OUTPUT_LN" || {
    echo -e "Failed to cd into directory '${OUTPUT_LN}'"
    exit 1
}

git add .
git commit -m "Automated deployment @ $(date)" || exit 30
git push

cd -
