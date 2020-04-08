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

_install_sxhkd_dependencies() {
  sudo apt install \
    xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev \
    libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev \
    libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev xdotool

}

_install_sxhkd() {
  local sxhkd_installation_dir=$1

  git clone https://github.com/baskerville/sxhkd.git
  cd sxhkd
  make && sudo make install
}

setup_sxhkd() {
  local sxhkd_installation_dir=$1

  _install_sxhkd_dependencies
  _install_sxhkd "$sxhkd_installation_dir"
}

if ! (return 0 2>/dev/null); then

  if [ $# -eq 0 ]; then
    _print_usage
    exit 1
  fi

  setup_sxhkd "$1"
fi
