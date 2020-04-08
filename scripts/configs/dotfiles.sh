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

_install_dotfiles() {
  local dotfiles_installation_dir=$1

  git clone git@github.com:ndtho8205/dotfiles.git
  cd dotfiles
  git submodule update --init --recursive
  ./install.sh
}

setup_dotfiles() {
  local dotfiles_installation_dir=$1

  _install_dotfiles "$dotfiles_installation_dir"
}

if ! (return 0 2>/dev/null); then

  if [ $# -eq 0 ]; then
    _print_usage
    exit 1
  fi

  setup_dotfiles "$1"
fi
