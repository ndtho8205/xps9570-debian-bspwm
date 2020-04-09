#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION] -u ALACRITTY_URL

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
    -u)
      url=$1
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

  if [ -z "$url" ]; then
    echo "error: the following arguments are required: -u ALACRITTY_URL"
    exit 1
  fi
}

setup_alacritty() {
  local alacritty_url="${1}"

  wget \
    -O Alacritty.deb \
    "$alacritty_url"
  sudo gdebi ${force:+'-n'} Alacritty.deb
  rm -rf Alacritty.deb
}

if ! (return 0 2>/dev/null); then
  url=

  _parse_params "$@"
  setup_alacritty "$url"

  unset url
fi
