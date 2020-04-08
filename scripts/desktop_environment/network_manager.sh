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

_install_packages() {
  sudo apt install network-manager
}

setup_network_manager() {
  _install_packages
}

if ! (return 0 2>/dev/null); then
  _install_packages
fi
