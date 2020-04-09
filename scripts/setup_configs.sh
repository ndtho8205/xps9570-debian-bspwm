#!/usr/bin/env bash

set -o errtrace
set -o nounset
set -o pipefail

SCRIPT_DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"

CONFIGS_SCRIPT_DIR="${SCRIPT_DIR}/configs"

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
