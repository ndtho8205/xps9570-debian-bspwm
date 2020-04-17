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

_install_bspwm_dependencies() {
  sudo apt install ${force:+'-y'} \
    xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev \
    libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev \
    libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev xdotool
}

setup_bspwm() {
  local bspwm_installation_dir="${1}/bspwm"

  _install_bspwm_dependencies

  git clone https://github.com/baskerville/bspwm.git "$bspwm_installation_dir"
  cd "$bspwm_installation_dir"
  make && sudo make install

  sudo update-alternatives --install \
    /usr/bin/x-session-manager x-session-manager \
    "$(command -v bspwm)" 90
}

if ! (return 0 2>/dev/null); then
  installation_dir=

  _parse_params "$@"
  setup_bspwm "$installation_dir"

  unset installation_dir
fi
