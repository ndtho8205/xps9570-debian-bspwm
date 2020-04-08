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

_install_rofi_dependencies() {
  sudo apt install ${force:+'-y'} \
    dh-autoreconf libbison-dev flex \
    libpango1.0-dev libpangocairo-1.0-0 libcairo2-dev \
    libglib2.0 librsvg2-dev libstartup-notification0-dev \
    libxkbcommon-dev libxkbcommon-x11-dev \
    libxcb-ewmh-dev libxcb-icccm4-dev \
    libxcb-randr0-dev libxcb-xinerama0-dev \
    libjpeg-dev libxcb1-dev libxcb-xrm-dev
}

setup_rofi() {
  local rofi_installation_dir="${1}/rofi"

  _install_rofi_dependencies

  git clone https://github.com/davatorium/rofi.git "$rofi_installation_dir"
  cd "$rofi_installation_dir"
  git checkout 1.5.4
  git submodule update --init --recursive

  autoreconf -i
  mkdir build && cd build
  ../configure --disable-check
  make && make install
}

if ! (return 0 2>/dev/null); then
  installation_dir=

  _parse_params "$@"
  setup_rofi "$installation_dir"

  unset installation_dir
fi
