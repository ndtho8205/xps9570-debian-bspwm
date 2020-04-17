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

install_packages() {
  sudo apt install ${force:+'-y'} \
    build-essential git wget curl gdebi unzip fontconfig xdg-user-dirs
}

makedirs() {
  mkdir -p "$HOME/.config"
  mkdir -p "$HOME/.local/bin"
  xdg-user-dirs-update
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  install_packages
  makedirs
fi
