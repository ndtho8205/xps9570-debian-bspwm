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

_install_bspwm_dependencies() {
  sudo apt install \
    xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev \
    libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev \
    libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev xdotool
}

_install_bspwm() {
  local bspwm_installation_dir=$1

  git clone https://github.com/baskerville/bspwm.git
  cd bspwm
  make && sudo make install
}

setup_bspwm() {
  local bspwm_installation_dir=$1

  _install_bspwm_dependencies
  _install_bspwm "$bspwm_installation_dir"

  sudo update-alternatives --install \
    /usr/bin/x-session-manager x-session-manager \
    "$(command -v bspwm)" 90
}

if ! (return 0 2>/dev/null); then

  if [ $# -eq 0 ]; then
    _print_usage
    exit 1
  fi

  setup_bspwm "$1"
fi
