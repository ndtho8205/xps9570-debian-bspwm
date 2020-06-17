#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

ROFI_LATEST_VERSION="1.5.4"

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION]

Options:
  -v VERSION     The version of rofi to install.
                 Default: $ROFI_LATEST_VERSION
  -h, --help     Show this help and exit
EOF
}

_parse_params() {
  local param
  version="$ROFI_LATEST_VERSION"

  while [[ $# -gt 0 ]]; do
    param="$1"
    shift

    case $param in
    -v)
      version=$1
      shift
      ;;
    -f | --force)
      force=true
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

_build_rofi() {
  apt install -y \
    dh-autoreconf libbison-dev flex \
    libpango1.0-dev libpangocairo-1.0-0 libcairo2-dev \
    libglib2.0 librsvg2-dev libstartup-notification0-dev \
    libxkbcommon-dev libxkbcommon-x11-dev \
    libxcb-ewmh-dev libxcb-icccm4-dev \
    libxcb-randr0-dev libxcb-xinerama0-dev \
    libjpeg-dev libxcb1-dev libxcb-xrm-dev

  git clone https://github.com/davatorium/rofi.git
  cd rofi
  git checkout "$version"
  git submodule update --init --recursive

  autoreconf -i
  mkdir build && cd build
  ../configure --disable-check --prefix=/usr
  make
}

_make_rofi_deb() {
  checkinstall \
    --type=debian \
    --install=no \
    --fstrans=no \
    --default \
    --pkgname="rofi" \
    --pkgversion="$version" \
    --requires="libc6,libcairo2,libglib2.0-0,libpango-1.0-0,libpangocairo-1.0-0,librsvg2-2,libstartup-notification0,libxcb-ewmh2,libxcb-randr0,libxcb-icccm4,libxcb-util0,libxcb-xinerama0,libxcb-xkb1,libxcb-xrm0,libxcb1,libxkbcommon-x11-0,libxkbcommon0" \
    --pakdir="../../build" \
    make install PREFIX=/usr
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  _build_rofi
  _make_rofi_deb

  unset version
fi
