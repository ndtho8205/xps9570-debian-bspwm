#!/usr/bin/env bash

set -o errtrace
set -o nounset
set -o pipefail

SCRIPT_DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"

CONFIGS_SCRIPT_DIR="${SCRIPT_DIR}/configs"

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

  info "Fonts"
  source "${CONFIGS_SCRIPT_DIR}/fonts.sh"
  setup_fonts
  check_run "Fonts"

  info "Git"
  source "${CONFIGS_SCRIPT_DIR}/git.sh"
  setup_git
  check_run "Git"

  info "Touchpad"
  source "${CONFIGS_SCRIPT_DIR}/touchpad.sh"
  setup_touchpad
  check_run "touchpad"
fi
