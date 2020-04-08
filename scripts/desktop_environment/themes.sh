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

_install_flat_themes() {
  local themes_installation_dir=$1

  git clone https://github.com/daniruiz/flat-remix-gtk.git
  cd flat-remix-gtk
  sudo make install
}

_install_suru_icons() {
  local icons_installation_dir=$1

  # suru-plus icons
  wget -qO- https://raw.githubusercontent.com/gusbemacbe/suru-plus/master/install.sh | sh

  # suru-plus-folders
  wget -qO- https://git.io/fhQdI | sh
  suru-plus-folders -l --theme Suru++
  suru-plus-folders -C violet --theme Suru++
}

setup_themes() {
  local installation_dir=$1

  _install_flat_themes "$installation_dir"
  _install_suru_icons "$installation_dir"

  sudo update-alternatives --install \
    /usr/bin/x-session-manager x-session-manager \
    "$(command -v themes)" 90
}

if ! (return 0 2>/dev/null); then

  if [ $# -eq 0 ]; then
    _print_usage
    exit 1
  fi

  setup_themes "$1"
fi
