#!/usr/bin/env bash

vi /etc/apt/sources.list
apt update && apt upgrade
apt install tmux htop psmisc

#{{{{****************************************************************
#====================================================================

#====================================================================
# DE pre-installation

# if you want to change xsession later
# sudo update-alternatives --config x-session-manager
# if GNOME had been already installed
# sudo cp bspwm/contrib/freedesktop/bspwm.desktop /usr/share/xsessions/

#****************************************************************}}}}

#{{{{****************************************************************

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
# volume control: pulseaudio + alsamixer

#****************************************************************}}}}

#====================================================================
# text editor

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
