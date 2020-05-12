#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION] -b GIT_BRANCH -i INSTALLATION_DIR

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
    -b)
      branch=$1
      shift
      ;;
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

  if [ -z "$branch" ]; then
    echo "error: the following arguments are required: -b GIT_BRANCH"
    exit 1
  fi

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
  local rofi_branch="${1}"
  local rofi_installation_dir="${2}/rofi"

  _install_rofi_dependencies

  git clone https://github.com/davatorium/rofi.git "$rofi_installation_dir"
  cd "$rofi_installation_dir"
  git checkout "$rofi_branch"
  git submodule update --init --recursive

  autoreconf -i
  mkdir build && cd build
  ../configure --disable-check
  make && sudo make install
}

if ! (return 0 2>/dev/null); then
  branch=
  installation_dir=

  _parse_params "$@"
  setup_rofi "$branch" "$installation_dir"

  unset branch
  unset installation_dir
fi
