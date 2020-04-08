#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
USAGE: $(basename "$0")
EOF
}

_install_common_fonts() {
  sudo apt install ttf-mscorefonts-installer ttf-dejavu
}

_install_east_asia_fonts() {
  # https://en.wikipedia.org/wiki/Help%3AMultilingual_support_%28East_Asian%29#Debian-based_GNU.2FLinux
  sudo apt install fonts-arphic-ukai fonts-arphic-uming fonts-ipafont-mincho fonts-ipafont-gothic fonts-unfonts-core
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

setup_fonts() {
  _install_common_fonts
  _install_east_asia_fonts

  fc-cache -fv
}

if ! (return 0 2>/dev/null); then
  setup_fonts
fi
