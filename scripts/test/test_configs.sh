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
  "audio.sh" \
  "./configs/audio.sh -f" \
  "type pulseaudio && type alsamixer"

test \
  "dotfiles.sh" \
  "./configs/dotfiles.sh -f --https -i /tmp" \
  "[ -d /tmp/dotfiles ]" \
  "[ -d ~/.dotfiles ] && [ -L ~/.vimrc ]"

test \
  "fonts.sh" \
  "./configs/fonts.sh -f" \
  "[ -d ~/.local/share/fonts ]" \
  "fc-list | grep JetBrains && fc-list | grep Times"

summary
