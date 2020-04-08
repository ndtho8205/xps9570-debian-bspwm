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

info "bspwm.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./desktop_environment/bspwm.sh -f -i /tmp && [ -d /tmp/bspwm ] && type bspwm"
assert "error: bspwm.sh fail"

info "dunst.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./desktop_environment/dunst.sh -f -i /tmp && [ -d /tmp/dunst ] && type dunst"
assert "error: dunst.sh fail"

info "network.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./desktop_environment/network.sh -f && type nmcli && type nmtui"
assert "error: network.sh fail"

info "picom.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./desktop_environment/picom.sh -f -i /tmp && [ -d /tmp/picom ] && type picom"
assert "error: picom.sh fail"

info "rofi.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./desktop_environment/rofi.sh -f -i /tmp && [ -d /tmp/rofi ] && type rofi"
assert "error: rofi.sh fail"

info "terminal_emulator.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./desktop_environment/terminal_emulator.sh -f && type alacritty"
assert "error: terminal_emulator.sh fail"

info "themes.sh"
docker run -it --rm "$IMAGE_NAME" \
  bash -c "./desktop_environment/themes.sh -f -i /tmp"
assert "error: themes.sh fail"
