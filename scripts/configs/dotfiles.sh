#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION] -i INSTALLATION_DIR

Options:
  --https        Use git using https (default: ssh) 
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
    --https)
      https=true
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

  if [ -z "$installation_dir" ]; then
    echo "error: the following arguments are required: -i INSTALLATION_DIR"
    exit 1
  fi
}

setup_dotfiles() {
  local dotfiles_installation_dir="${1}/dotfiles"

  if [ $https ]; then
    git clone https://github.com/ndtho8205/dotfiles.git "$dotfiles_installation_dir"
  else
    git clone git@github.com:ndtho8205/dotfiles.git "$dotfiles_installation_dir"
  fi

  cd "$dotfiles_installation_dir"
  git submodule update --init --recursive

  ./install.sh ${force:+'-f'}
}

if ! (return 0 2>/dev/null); then
  installation_dir=
  https=

  _parse_params "$@"
  setup_dotfiles "$installation_dir"

  unset installation_dir
  unset https
fi
