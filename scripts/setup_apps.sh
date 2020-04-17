#!/usr/bin/env bash

set -o errtrace
set -o nounset
set -o pipefail

SCRIPT_DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"

APPS_SCRIPT_DIR="${SCRIPT_DIR}/apps"

force=

_print_usage() {
  cat <<EOF
  usage: $(basename "$0") [OPTION]
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
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  source "${SCRIPT_DIR}/helpers/utils.sh"

  info "Google Chrome"
  source "${APPS_SCRIPT_DIR}/google-chrome.sh"
  install_chrome
  check_run "Google Chrome"
fi
