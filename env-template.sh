#!/usr/bin/env bash

# shellcheck disable=SC2016
export ENV_TEMPLATE='#!/usr/bin/env bash

export OUTPUT_LN=nirokay.com  # SymLink name in current directory

export OUTPUT_DIR=""          # Actual destination, overwrite or it will be
                              # attempted to be detected in ~/Git/... or using
                              # `$GITMAN_REPOS_LOCATION`
'
