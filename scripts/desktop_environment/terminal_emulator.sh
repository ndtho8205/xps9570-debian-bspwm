#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION]

Options:
  -f, --force    Skip all user interaction. Implied 'Yes' to all actions
  -h, --help     Show this help and exit
EOF
}

_parse_params() {
  local param
  while [[ $# -gt 0 ]]; do
    param="$1"
    shift

    case $param in
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

setup_alacritty() {
  wget \
    -O Alacritty.deb \
    https://github.com/alacritty/alacritty/releases/download/v0.4.2-rc3/Alacritty-v0.4.2-rc3-ubuntu_18_04_amd64.deb
  sudo gdebi ${force:+'-n'} Alacritty.deb
  rm -rf Alacritty.deb
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"
  setup_alacritty
fi
