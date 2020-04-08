#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
USAGE: $(basename "$0") INSTALLATION_DIR
EOF
}

_install_picom_dependencies() {
  sudo apt install meson ninja-build \
    libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev \
    libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev \
    libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev \
    libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev \
    libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev \
    libevdev-dev uthash-dev libev-dev libx11-xcb-dev
}

_install_picom() {
  local picom_installation_dir=$1

  git clone https://github.com/yshui/picom.git
  git checkout vNext

  cd picom
  git submodule update --init --recursive
  meson --buildtype=release . build
  ninja -C build
  sudo ninja -C build install
}

setup_bspwm() {
  local picom_installation_dir=$1

  _install_picom_dependencies
  _install_picom"$picom_installation_dir"
}

if ! (return 0 2>/dev/null); then

  if [ $# -eq 0 ]; then
    _print_usage
    exit 1
  fi

  setup_picom"$1"
fi
