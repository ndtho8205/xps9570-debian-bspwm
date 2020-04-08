#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

vi /etc/apt/sources.list
apt update && apt upgrade
apt install build-essential git wget curl gdebi unzip \
  vim-gtk3 tmux htop tree psmisc

#{{{{****************************************************************
#====================================================================
# display server: X.Org
sudo apt install xorg

#====================================================================
# display manager: LightDM
sudo apt install lightdm

#====================================================================
# DE pre-installation
mkdir -p ~/Documents/ProgramFiles/DE
cd ~/Documents/ProgramFiles/DE

#====================================================================
# window manager: bspwm & sxhkd

# if you want to change xsession later
# sudo update-alternatives --config x-session-manager
# if GNOME had been already installed
# sudo cp bspwm/contrib/freedesktop/bspwm.desktop /usr/share/xsessions/

#====================================================================
# terminal emulator: Alacritty

#====================================================================
# zsh
sudo apt install zsh
chsh -s $(which zsh)

#====================================================================
# dotfiles
mkdir -p ~/Documents/Projects/GitHubProjects
cd ~/Documents/Projects/GitHubProjects

git clone git@github.com:ndtho8205/dotfiles.git
cd dotfiles
git submodule update --init --recursive
./install.sh

reboot
#****************************************************************}}}}

#{{{{****************************************************************
#====================================================================
# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi google*.deb
rm -rf google*.deb

#====================================================================
# gtk

# screenshot
sudo apt install maim

# wallpapers
sudo apt install feh

# themes
sudo apt install lxappearance
cd ~/Documents/ProgramFiles/DE
git clone https://github.com/daniruiz/flat-remix-gtk.git
cd flat-remix-gtk
sudo make install

# suru-plus icons
wget -qO- https://raw.githubusercontent.com/gusbemacbe/suru-plus/master/install.sh | sh

# suru-plus-folders
wget -qO- https://git.io/fhQdI | sh
suru-plus-folders -l --theme Suru++
suru-plus-folders -C violet --theme Suru++

#====================================================================
# file manager + archive manager
sudo apt install nemo file-roller

#====================================================================
# application launcher: rofi
cd ~/Documents/ProgramFiles/DE
git clone https://github.com/davatorium/rofi.git
cd rofi
git checkout 1.5.4
git submodule update --init --recursive

sudo apt install \
  dh-autoreconf libbison-dev flex \
  libpango1.0-dev libpangocairo-1.0-0 libcairo2-dev \
  libglib2.0 librsvg2-dev libstartup-notification0-dev \
  libxkbcommon-dev libxkbcommon-x11-dev \
  libjpeg-dev libxcb1-dev libxcb-xrm-dev

autoreconf -i
mkdir build && cd build
../configure --disable-check
make && make install

#====================================================================
# compositor: picom
cd ~/Documents/ProgramFiles/DE

sudo apt install meson ninja-build \
  libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev \
  libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev \
  libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev \
  libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev \
  libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev \
  libevdev-dev uthash-dev libev-dev libx11-xcb-dev

git clone https://github.com/yshui/picom.git
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

#====================================================================
# notification: dunst
cd ~/Documents/ProgramFiles/DE
git clone https://github.com/dunst-project/dunst.git
cd dunst
git checkout v1.4.1

sudo apt install libdbus-1-dev libx11-dev libxinerama-dev \
  libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev \
  libgtk-3-dev libxdg-basedir-dev libnotify-dev

make && sudo make install

make dunstify
cp -vs $(pwd)/dunstify ~/.local/bin/

#====================================================================
# volume control: pulseaudio + alsamixer
sudo apt install pulseaudio alsa-utils

reboot
#****************************************************************}}}}

#====================================================================
# text editor

#====================================================================
# network manager: nmtui + nmcli
sudo apt install network-manager

#====================================================================
# power management

#====================================================================
# mount tool

#====================================================================
# authentication

#====================================================================
# screen locker
# light-locker

#====================================================================
# default applications

#====================================================================
# Fix Mouse
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

#====================================================================
