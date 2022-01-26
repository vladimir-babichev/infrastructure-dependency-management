#!/usr/bin/env bash

root_dir=$(git rev-parse --show-toplevel)
: "${ROOT_DIR=$root_dir}"
export ROOT_DIR=$ROOT_DIR

info() {
    echo -e "[INFO] $1"
}

err() {
    echo -e "[ERROR] $1"
}

fail() {
    [ -n "$2" ] && err_code=$2 || err_code=1
    err "$1"
    exit $err_code
}
