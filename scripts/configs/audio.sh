#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
USAGE: $(basename "$0")
EOF
}

_install_packages() {
  sudo apt install pulseaudio alsa-utils
}

config_audio() {
  _install_packages
}

if ! (return 0 2>/dev/null); then

  if [ $# -eq 0 ]; then
    _print_usage
    exit 1
  fi

  config_audio "$1"
fi
