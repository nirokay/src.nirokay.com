#!/usr/bin/env bash

# shellcheck source=/dev/null
source "./env.sh"

tsc -p ./src/javascript/ --outDir "./${OUTPUT_LN}/javascript/"
