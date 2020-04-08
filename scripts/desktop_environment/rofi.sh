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

_install_rofi_dependencies() {
  sudo apt install \
    dh-autoreconf libbison-dev flex \
    libpango1.0-dev libpangocairo-1.0-0 libcairo2-dev \
    libglib2.0 librsvg2-dev libstartup-notification0-dev \
    libxkbcommon-dev libxkbcommon-x11-dev \
    libjpeg-dev libxcb1-dev libxcb-xrm-dev
}

_install_rofi() {
  local rofi_installation_dir=$1

  git clone https://github.com/davatorium/rofi.git
  cd rofi
  git checkout 1.5.4
  git submodule update --init --recursive

  autoreconf -i
  mkdir build && cd build
  ../configure --disable-check
  make && make install

}

setup_rofi() {
  local rofi_installation_dir=$1

  _install_rofi_dependencies
  _install_rofi "$rofi_installation_dir"
}

if ! (return 0 2>/dev/null); then

  if [ $# -eq 0 ]; then
    _print_usage
    exit 1
  fi

  setup_rofi "$1"
fi
