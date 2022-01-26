#!/bin/bash

# Source common functions
# shellcheck source=/dev/null
source "$(dirname "$(realpath "$0")")/common.sh"

help() {
    cat <<EOF
    To display this help again use this flags:    -h, --help

    Parameters:
    -n, --namespace     Target namespace
EOF
}


while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -n|--namespace)
        namespace="$2"
        shift
        ;;
    -h|--help)
        help
        exit 0
        ;;
    *)
        fail "Parameter $1 not recognized!"
        ;;
  esac
  shift
done

[[ -z "$namespace" ]] && fail "Namespace cannot be null!"

if ! kubectl get ns "$namespace" >/dev/null 2>&1; then
    kubectl create namespace "$namespace"
fi

kubens "$namespace"

cd "${ROOT_DIR}/k8s/gitops/apps" || fail
cat ./*.yaml | kubectl apply -f -
