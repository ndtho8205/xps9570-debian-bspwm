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

_install_dunst_dependencies() {
  sudo apt install ${force:+'-y'} \
    libdbus-1-dev libx11-dev libxinerama-dev \
    libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev \
    libgtk-3-dev libxdg-basedir-dev libnotify-dev
}

setup_dunst() {
  local dunst_branch="${1}"
  local dunst_installation_dir="${2}/dunst"

  _install_dunst_dependencies

  git clone https://github.com/dunst-project/dunst.git "$dunst_installation_dir"
  cd "$dunst_installation_dir"
  git checkout "$dunst_branch"
  make && sudo make install

  make dunstify
  cp -vs "${dunst_installation_dir}/dunstify" ~/.local/bin/
}

if ! (return 0 2>/dev/null); then
  branch=
  installation_dir=

  _parse_params "$@"
  setup_dunst "$branch" "$installation_dir"

  unset branch
  unset installation_dir
fi
