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

_install_dependencies() {
  sudo add-apt-repository -y ppa:linrunner/tlp
  sudo apt -y update
  sudo apt -y install thermald tlp tlp-rdw powertop

}
setup_power_management() {
  _install_dependencies

  systemctl restart tlp
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  setup_power_management
fi
