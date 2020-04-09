#!/usr/bin/env bash

set -o errtrace
set -o nounset
set -o pipefail

SCRIPT_DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"

APPS_SCRIPT_DIR="${SCRIPT_DIR}/apps"

source "${SCRIPT_DIR}/helpers/utils.sh"

info "Google Chrome"
source "${APPS_SCRIPT_DIR}/google-chrome.sh"
install_chrome
check_run "Google Chrome"
