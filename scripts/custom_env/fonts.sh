#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

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

_install_east_asia_fonts() {
  # https://en.wikipedia.org/wiki/Help%3AMultilingual_support_%28East_Asian%29#Debian-based_GNU.2FLinux
  sudo apt install ${force:+'-y'} fonts-arphic-ukai fonts-arphic-uming fonts-ipafont-mincho fonts-ipafont-gothic fonts-unfonts-core
}

_install_jetbrainsmono_nerd_font() {
  local fontUrls=(
    "https://github.com/ndtho8205/JetBrainsMono/raw/nerd-fonts/nerd-fonts/JetBrainsMono_Nerd_Bold.ttf"
    "https://github.com/ndtho8205/JetBrainsMono/raw/nerd-fonts/nerd-fonts/JetBrainsMono_Nerd_Italic.ttf"
    "https://github.com/ndtho8205/JetBrainsMono/raw/nerd-fonts/nerd-fonts/JetBrainsMono_Nerd_Medium.ttf"
    "https://github.com/ndtho8205/JetBrainsMono/raw/nerd-fonts/nerd-fonts/JetBrainsMono_Nerd_Regular.ttf"
  )

  for fontUrl in "${fontUrls[@]}"; do
    wget -P ~/.local/share/fonts "${fontUrl}"
  done
}

_install_ms_fonts() {
  sudo apt install ${force:+'-y'} ttf-mscorefonts-installer
}

_install_emoji_fonts() {
  sudo apt install fonts-noto-color-emoji
}

setup_fonts() {
  _install_east_asia_fonts
  _install_jetbrainsmono_nerd_font
  _install_ms_fonts
  _install_emoji_fonts

  fc-cache -fv
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  setup_fonts
fi
