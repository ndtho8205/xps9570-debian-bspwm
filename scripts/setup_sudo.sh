#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

user=$(id -un)

# run as root
# su -

# install sudo package
apt update
apt install ${force:+'-y'} sudo

# add current user to sudo group
usermod -aG sudo "$user"

# reboot
reboot
