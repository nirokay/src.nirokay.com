#!/usr/bin/env bash

# shellcheck source=/dev/null
source ./env.sh

./compile-typescript.sh || exit 10
nimble run || exit 11

cd "$OUTPUT_LN" || exit 20

git add .
git commit -m "Automated deployment @ $(date)" || exit 30
git push
