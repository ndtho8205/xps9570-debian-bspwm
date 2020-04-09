#!/usr/bin/env bash

SCRIPT_DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)/.."

IMAGE_NAME="bspwm_scripts_test"

errors=()

source "${SCRIPT_DIR}/helpers/utils.sh"
source "${SCRIPT_DIR}/helpers/test.sh"

info "Building image"
docker build --force-rm --quiet --tag "$IMAGE_NAME" "$SCRIPT_DIR"
docker image prune -f

test \
  "google-chrome.sh" \
  "./apps/google-chrome.sh -f" \
  "type google-chrome"

summary
