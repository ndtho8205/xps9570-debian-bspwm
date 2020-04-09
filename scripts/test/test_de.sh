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
  "bspwm.sh" \
  "./desktop_environment/bspwm.sh -f -i /tmp" \
  "[ -d /tmp/bspwm ]" \
  "type bspwm"

test \
  "dunst.sh" \
  "./desktop_environment/dunst.sh -f -i /tmp" \
  "[ -d /tmp/dunst ]" \
  "type dunst"

test \
  "network.sh" \
  "./desktop_environment/network.sh -f" \
  "type nmcli" \
  "type nmtui"

test \
  "picom.sh" \
  "./desktop_environment/picom.sh -f -i /tmp" \
  "[ -d /tmp/picom ]" \
  "type picom"

test \
  "rofi.sh" \
  "./desktop_environment/rofi.sh -f -i /tmp" \
  "[ -d /tmp/rofi ]" \
  "type rofi"

test \
  "terminal_emulator.sh" \
  "./desktop_environment/terminal_emulator.sh -f" \
  "type alacritty"

test \
  "themes.sh" \
  "./desktop_environment/themes.sh -f -i /tmp"

summary
