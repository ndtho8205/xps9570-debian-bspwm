#!/usr/bin/env bash

vi /etc/apt/sources.list
apt update && apt upgrade
apt install vim-gtk3 tmux htop tree psmisc

#{{{{****************************************************************
#====================================================================
# display server: X.Org
sudo apt install xorg

#====================================================================
# display manager: LightDM
sudo apt install lightdm

#====================================================================
# DE pre-installation

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

#****************************************************************}}}}

#{{{{****************************************************************
#====================================================================
# chrome

#====================================================================
# gtk

# screenshot
sudo apt install maim

# wallpapers
sudo apt install feh

# themes
sudo apt install lxappearance
# suru-plus icons
# suru-plus-folders

#====================================================================
# file manager + archive manager
sudo apt install nemo file-roller

#====================================================================
# application launcher: rofi

#====================================================================
# compositor: picom

#====================================================================
# notification: dunst

#====================================================================
# volume control: pulseaudio + alsamixer

#****************************************************************}}}}

#====================================================================
# text editor

#====================================================================
# network manager: nmtui + nmcli

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
