#!/usr/bin/env bash

set -o errtrace
set -o nounset
set -o pipefail

SCRIPT_DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"

DE_SCRIPT_DIR="${SCRIPT_DIR}/desktop_environment"

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

  INSTALLATION_DIR="$HOME/Documents/ProgramFiles/DE"
  mkdir -p "$INSTALLATION_DIR"

  DUNST_BRANCH="v1.4.1"
  PICOM_BRANCH="vNext"
  ROFI_BRANCH="1.5.4"
  ALACRITTY_URL="https://github.com/alacritty/alacritty/releases/download/v0.4.2/Alacritty-v0.4.2-ubuntu_18_04_amd64.deb"

  info "Audio"
  source "${DE_SCRIPT_DIR}/audio.sh"
  setup_audio
  check_run "Audio"

  info "bspwm"
  source "${DE_SCRIPT_DIR}/bspwm.sh"
  setup_bspwm "${INSTALLATION_DIR}"
  check_run "bspwm"

  info "dotfiles"
  source "${DE_SCRIPT_DIR}/dotfiles.sh"
  setup_dotfiles "${INSTALLATION_DIR}"
  check_run "dotfiles"

  info "dunst"
  source "${DE_SCRIPT_DIR}/dunst.sh"
  setup_dunst "${INSTALLATION_DIR}" -b "${DUNST_BRANCH}"
  check_run "dunst"

  info "network"
  source "${DE_SCRIPT_DIR}/network.sh"
  setup_network
  check_run "network"

  info "picom"
  source "${DE_SCRIPT_DIR}/picom.sh"
  setup_picom "${INSTALLATION_DIR}" -b "${PICOM_BRANCH}"
  check_run "picom"

  info "rofi"
  source "${DE_SCRIPT_DIR}/rofi.sh"
  setup_rofi "${INSTALLATION_DIR}" -b "${ROFI_BRANCH}"
  check_run "rofi"

  info "Terminal emulator"
  source "${DE_SCRIPT_DIR}/terminal_emulator.sh"
  setup_alacritty "${ALACRITTY_URL}"
  check_run "Terminal emulator"

  info "Themes"
  source "${DE_SCRIPT_DIR}/themes.sh"
  setup_themes "${INSTALLATION_DIR}"
  check_run "Themes"
fi
