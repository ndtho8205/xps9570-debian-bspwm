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

setup_touchpad() {
  sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee /etc/X11/xorg.conf.d/90-touchpad.conf <<'EOF' 1>/dev/null
Section "InputClass"
  Identifier "touchpad"
  MatchIsTouchpad "on"
  Driver "libinput"
  Option "Tapping" "on"
  Option "TappingButtonMap" "lrm"
  Option "NaturalScrolling" "on"
  Option "ScrollMethod" "twofinger"
EndSection
EOF
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"
  setup_touchpad
fi
