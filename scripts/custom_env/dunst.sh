#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

DUNST_LATEST_VERSION="1.4.1"

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION]

Options:
  -v VERSION     The version of dunst to install.
                 Defaul: $DUNST_LATEST_VERSION
  -h, --help     Show this help and exit
EOF
}

_parse_params() {
  local param
  version="$DUNST_LATEST_VERSION"

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

_build_dunst() {
  apt install -y \
    libdbus-1-dev libx11-dev libxinerama-dev \
    libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev \
    libgtk-3-dev libxdg-basedir-dev libnotify-dev

  git clone https://github.com/dunst-project/dunst.git
  cd dunst
  # git checkout "v$version"
  make PREFIX=/usr all
}

_make_dunst_deb() {
  PREFIX=/usr checkinstall \
    --type=debian \
    --install=no \
    --fstrans=no \
    --default \
    --pkgversion="$version" \
    --requires="default-dbus-session-bus,libc6,libcairo2,libdbus-1-3,libgdk-pixbuf2.0-0,libglib2.0-0,libpango-1.0-0,libpangocairo-1.0-0,libx11-6,libxdg-basedir1,libxinerama1,libxrandr2,libxss1,libnotify-bin" \
    --provides="notification-daemon" \
    --pakdir="../build" \
    make PREFIX=/usr install

}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  _build_dunst
  _make_dunst_deb

  unset version
fi
