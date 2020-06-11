#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

BSPWM_LATEST_VERSION="0.9.9"

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION]

Options:
  -v VERSION     The version of bspwm to install.
                 Default: $BSPWM_LATEST_VERSION
  -h, --help     Show this help and exit

EOF
}

_parse_params() {
  local param
  version="$BSPWM_LATEST_VERSION"

  while [[ $# -gt 0 ]]; do
    param="$1"
    shift

    case $param in
    -v)
      version=$1
      shift
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

_build_bspwm() {
  apt install -y \
    xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev \
    libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev \
    libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev xdotool

  git clone https://github.com/baskerville/bspwm.git
  cd bspwm
  git checkout "$version"
  make
}

_make_bspwm_deb() {
  checkinstall \
    --type=debian \
    --install=no \
    --fstrans=no \
    --default \
    --pkgversion="$version" \
    --requires="libc6,libxcb-ewmh2,libxcb-icccm4,libxcb-keysyms1,libxcb-randr0,libxcb-util0,libxcb-xinerama0,libxcb1,x11-utils" \
    --provides="x-window-manager" \
    --pakdir="../build" \
    make install PREFIX=/usr
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  _build_bspwm
  _make_bspwm_deb

  unset version
fi
