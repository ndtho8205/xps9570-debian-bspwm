#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
USAGE: $(basename "$0") ALACRITTY_VERSION
EOF
}

_install_alacritty() {
  local alacritty_version=$1

  wget https://github.com/alacritty/alacritty/releases/download/v0.4.2-rc3/Alacritty-v0.4.2-rc3-ubuntu_18_04_amd64.deb
  sudo gdebi Ala*.deb
  rm -rf Ala*
}

setup_alacritty() {
  local alacritty_version=$1

  _install_Alacritty "$alacritty_version"
}

if ! (return 0 2>/dev/null); then

  if [ $# -eq 0 ]; then
    _print_usage
    exit 1
  fi

  _install_Alacritty "$1"
fi
