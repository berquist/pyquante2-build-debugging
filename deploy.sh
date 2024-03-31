#!/bin/bash

set -euo pipefail

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

deploy_files=(
    Dockerfile.avail_not_requested
    Dockerfile.avail_requested
    Dockerfile.base
    Dockerfile.not_avail_not_requested
    Dockerfile.not_avail_requested
    Justfile
    venv.bash
)

# shellcheck: disable=SC2068
for f in ${deploy_files[@]}; do
    ln -fsv "${SCRIPTDIR}/${f}" "${PWD}/${f}"
done
