#!/usr/bin/env bash

SCRIPT_DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)/.."

IMAGE_NAME="bspwm_scripts_test"

source "${SCRIPT_DIR}/helpers/utils.sh"

info "Building image"
docker build --force-rm --quiet --tag "$IMAGE_NAME" "$SCRIPT_DIR"
docker image prune -f

info "google-chrome.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./apps/google-chrome.sh -f && type google-chrome"
assert "error: google-chrome.sh fail"
