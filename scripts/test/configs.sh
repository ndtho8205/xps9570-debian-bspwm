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
  "fonts.sh" \
  "./configs/fonts.sh -f" \
  "[ -d ~/.local/share/fonts ]" \
  "fc-list | grep JetBrains && fc-list | grep Times"

test \
  "git.sh" \
  "./configs/git.sh --test" \
  "ls ~/.ssh | grep github" \
  "ls ~/.ssh | grep gitlab"

test \
  "touchpad.sh" \
  "./configs/touchpad.sh" \
  "[ -f /etc/X11/xorg.conf.d/90-touchpad.conf ]"

summary
