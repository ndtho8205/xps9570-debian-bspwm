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

info "audio.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./configs/audio.sh -f && type pulseaudio && type alsamixer"
assert "error: audio.sh fail"

info "dotfiles.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./configs/dotfiles.sh -f --https -i /tmp && [ -d /tmp/dotfiles ] && [ -d ~/.dotfiles ] && [ -L ~/.vimrc ]"
assert "error: dotfiles.sh fail"

info "fonts.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./configs/fonts.sh -f && [ -d ~/.local/share/fonts ] && fc-list | grep JetBrains && fc-list | grep Times"
assert "error: fonts.sh fail"
