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

_install_dunst_dependencies() {
  sudo apt install libdbus-1-dev libx11-dev libxinerama-dev \
    libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev \
    libgtk-3-dev libxdg-basedir-dev libnotify-dev
}

_install_dunst() {
  local dunst_installation_dir=$1

  git clone https://github.com/dunst-project/dunst.git
  cd dunst
  git checkout v1.4.1

  make && sudo make install
  make dunstify

  cp -vs $(pwd)/dunstify ~/.local/bin/
}

setup_dunst() {
  local dunst_installation_dir=$1

  _install_dunst_dependencies
  _install_dunst "$dunst_installation_dir"
}

if ! (return 0 2>/dev/null); then

  if [ $# -eq 0 ]; then
    _print_usage
    exit 1
  fi

  setup_dunst "$1"
fi
