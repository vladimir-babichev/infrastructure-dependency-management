#!/usr/bin/env bash

# Source common functions
# shellcheck source=/dev/null
source "$(dirname "$(realpath "$0")")/include/common.sh"

"${ROOT_DIR}"/scripts/include/vault.sh --namespace core
"${ROOT_DIR}"/scripts/include/argocd.sh --namespace gitops
"${ROOT_DIR}"/scripts/include/apps.sh --namespace gitops
