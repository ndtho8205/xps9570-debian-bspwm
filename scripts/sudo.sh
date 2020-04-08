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
setup_sudo() {
  local _user=$USER

  # run as root
  su -

  # install sudo package
  apt update && apt upgrade
  apt install sudo

  # add current user to sudo group
  usermod -aG sudo "$_user"

  # reboot
  reboot
}

if ! (return 0 2>/dev/null); then
  setup_sudo
fi
