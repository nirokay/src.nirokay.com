#!/usr/bin/env bash

source env-init.sh

cd "$OUTPUT_LN" || exit 1
git add .
git commit -m "Automated deployment @ $(date)"
git push
