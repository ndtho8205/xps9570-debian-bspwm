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

_install_picom_dependencies() {
  sudo apt install ${force:+'-y'} \
    meson ninja-build libxdg-basedir-dev libpcre++-dev \
    libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev \
    libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev \
    libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev \
    libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev \
    libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev \
    libevdev-dev uthash-dev libev-dev libx11-xcb-dev
}

setup_picom() {
  local picom_installation_dir="${1}/picom"

  _install_picom_dependencies

  git clone https://github.com/yshui/picom.git "$picom_installation_dir"
  cd "$picom_installation_dir"
  git checkout vNext
  git submodule update --init --recursive

  meson --buildtype=release . build
  ninja -C build
  sudo ninja -C build install
}

if ! (return 0 2>/dev/null); then
  installation_dir=

  _parse_params "$@"
  setup_picom "$installation_dir"

  unset installation_dir
fi
