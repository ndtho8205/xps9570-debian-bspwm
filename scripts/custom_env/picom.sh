#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

PICOM_LATEST_VERSION="8"

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION]

Options:
  -v VERSION     The version of bspwm to install.
                 Default: $PICOM_LATEST_VERSION
  -h, --help     Show this help and exit
EOF
}

_parse_params() {
  local param
  version="$PICOM_LATEST_VERSION"

  while [[ $# -gt 0 ]]; do
    param="$1"
    shift

    case $param in
    -v)
      version="$1"
      ;;
    -h | --help)
      _print_usage
      exit 0
      ;;
    *)
      echo "error: unrecognized arguments: $param"
      exit 1
      ;;
    esac
  done
}

_build_picom() {
  apt install -y \
    meson ninja-build libxdg-basedir-dev libpcre++-dev \
    libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev \
    libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev \
    libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev \
    libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev \
    libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev \
    libevdev-dev uthash-dev libev-dev libx11-xcb-dev

  git clone https://github.com/yshui/picom.git
  cd picom
  git checkout "v$version"
  git submodule update --init --recursive

  meson --prefix=/usr --buildtype=release . build
  ninja -C build
}

_make_picom_deb() {
  checkinstall \
    --type=debian \
    --install=no \
    --fstrans=no \
    --default \
    --pkgversion="$version" \
    --requires="libc6,libconfig9,libdbus-1-3,libev4,libgl1,libpcre3,libpixman-1-0,libx11-6,libx11-xcb1,libxcb-composite0,libxcb-damage0,libxcb-glx0,libxcb-image0,libxcb-present0,libxcb-randr0,libxcb-render-util0,libxcb-render0,libxcb-shape0,libxcb-sync1,libxcb-xfixes0,libxcb-xinerama0,libxcb1" \
    --pakdir="../build" \
    ninja -C build install
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  _build_picom
  _make_picom_deb

  unset version
fi
