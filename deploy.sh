#!/usr/bin/env bash

# shellcheck source=/dev/null
source ./env.sh

function cdGitModule() {
    cd "$OUTPUT_LN" || {
        echo -e "Failed to cd into directory '${OUTPUT_LN}'"
        exit 1
    }
}


# Clean build:
cdGitModule
    git restore .
cd -

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


# Git submodule:
COMMIT_MSG="Automated deployment @ $(date)"

cdGitModule
    git add .
    if ! git commit -S -m COMMIT_MSG; then
        echo -e "Failed signed commit, retrying without signing..."
        if ! git commit -m COMMIT_MSG; then
            echo -e "Failed to commit changes"
            cd -
            exit 1
        fi
    fi
    git push
cd -
