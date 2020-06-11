#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

SXHKD_LATEST_VERSION="0.6.1"

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION]

Options:
  -v VERSION     The version of sxhkd to install.
                 Default: $SXHKD_LATEST_VERSION
  -h, --help     Show this help and exit
EOF
}

_parse_params() {
  local param
  version="$SXHKD_LATEST_VERSION"

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

_build_sxhkd() {
  apt install -y \
    xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev \
    libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev \
    libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev xdotool

  git clone https://github.com/baskerville/sxhkd.git
  cd sxhkd
  git checkout "$version"
  make
}

_make_sxhkd_deb() {
  checkinstall \
    --type=debian \
    --install=no \
    --fstrans=no \
    --default \
    --pkgversion="$version" \
    --requires="libc6,libxcb-keysyms1,libxcb1" \
    --provides="x-window-manager" \
    --pakdir="../build" \
    make install PREFIX=/usr
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  _build_sxhkd
  _make_sxhkd_deb

  unset version
fi
