#!/usr/bin/env bash

source env.sh

./compile-javascript.sh
# cp -r src/javascript/* "$OUTPUT_LN"/javascript || exit 1

cd "$OUTPUT_LN" || exit 2
git add .
git commit -m "Automated deployment @ $(date)"
git push
