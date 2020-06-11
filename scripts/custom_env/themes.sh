#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION] -i INSTALLATION_DIR

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
    -i)
      installation_dir=$1
      shift
      ;;
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

  if [ -z "$installation_dir" ]; then
    echo "error: the following arguments are required: -i INSTALLATION_DIR"
    exit 1
  fi
}

_install_flat_themes() {
  local themes_installation_dir="${1}/flat-remix-gtk"

  git clone https://github.com/daniruiz/flat-remix-gtk.git "$themes_installation_dir"
  cd "$themes_installation_dir"
  sudo make install
}

_install_suru_icons() {
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
  _install_suru_icons
}

if ! (return 0 2>/dev/null); then
  installation_dir=

  _parse_params "$@"
  setup_themes "$installation_dir"

  unset installation_dir
fi
