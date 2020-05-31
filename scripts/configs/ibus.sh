#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION]

Options:
  -h, --help     Show this help and exit
EOF
}

_parse_params() {
  local param
  while [[ $# -gt 0 ]]; do
    param="$1"
    shift

    case $param in
    --test)
      test=true
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
}

setup_ibus() {
  sudo apt install ibus

  echo ""
  echo "Edit '/usr/bin/ibus-setup' file"
  echo "Change 'exec python 3' to 'exec /usr/bin/python3'"
  echo "Press any key to continue..."
  read -r

  wget -O ibus-bamboo.deb \
    https://download.opensuse.org/repositories/home:/lamlng/Debian_9.0/amd64/ibus-bamboo_0.6.5-0_amd64.deb
  sudo gdebi ibus-bamboo.deb

  ibus-daemon -rdx

  echo ""
  echo "Open a new terminal and run 'ibus-setup' command..."
  echo "Press any key to continue..."
  read -r

  echo ""
  echo "Log out and login again."
  echo ""
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  setup_ibus
fi
