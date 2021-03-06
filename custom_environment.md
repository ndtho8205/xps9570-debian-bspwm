# Building Custom Environment

## Booting

1. **Microcode**

   Install Intel microcode to ensure system stability and prevent bugs/errata
   that may cause incorrect processing, data corruption, and system lockups.

   ```sh
   sudo apt install --no-install-recommends intel-microcode
   ```

   Reboot and check the microcode version.

   ```sh
   sudo journalctl -b -k | grep "microcode updated early to"
   ```

## Graphical User Interface

1. **Display Server**: `Xorg`

   ```sh
   # full
   sudo apt install --no-install-recommends xorg

   # or minimal installation (recommended)
   sudo apt install --no-install-recommends \
     xserver-xorg-core xinit x11-xserver-utils \
     xserver-xorg-input-libinput \
     xserver-xorg-video-fbdev \
     xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable\
   ```

2. **Display Drivers**

3. **Window Managers**: `bspwm`

   ```sh
   sudo apt install --no-install-recommends sxhkd bspwm xdotool

   sudo update-alternatives \
     --install /usr/bin/x-window-manager\
     x-window-manager $(command -v bspwm)" 90
   ```

   It is important to have `bspwm` and `sxhkd` configs in the right place. You
   can create the default configs for them as follows:

   ```sh
   cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
   cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
   chmod +x ~/.config/bspwm/bspwmrc
   ```

4. **Display Manager**: `LightDM`

   ```sh
   sudo apt install --no-install-recommends lightdm
   sudo lightdm --show-config # show current configurations
   ```

5. Window switcher, run dialog: _rofi_

   ```sh
   sudo apt install rofi
   ```

6. Desktop notifications: _dunst_

   ```sh
   sudo apt install dunst libnotify-bin
   ```

7. Terminal Emulator: _Alacritty_

   ```sh
   wget -O Alacritty.deb https://github.com/alacritty/alacritty/releases/download/v0.4.2/Alacritty-v0.4.2-ubuntu_18_04_amd64.deb
   sudo gdebi Alacritty.deb
   ```

8. **User Directories**

   ```sh
   sudo apt install xdg-user-dirs
   ```

   Edit `~/.config/user-dirs.dirs` file as follow:

   ```sh
   XDG_DOWNLOAD_DIR="$HOME/Downloads"
   XDG_TEMPLATES_DIR="$HOME/Templates"
   XDG_PUBLICSHARE_DIR="$HOME/Public"
   XDG_DOCUMENTS_DIR="$HOME/Documents"
   XDG_MUSIC_DIR="$HOME/"
   XDG_PICTURES_DIR="$HOME/Pictures"
   XDG_VIDEOS_DIR="$HOME/"
   XDG_DESKTOP_DIR="$HOME/"
   ```

   Create default user directories:

   ```sh
   xdg-user-dirs-update
   ```

9. Composite managers: _picom_

10. Configurations

    - Install my configs

      ```sh
      git clone https://github.com/ndtho8205/de-configs.git
      cd de-configs
      ./install.sh
      ```

**Note:** Now you can reboot the system. Lightdm login screen will be showed.
After login, press <kbd>Windows</kbd> + <kbd>Enter</kbd> to open a terminal.

## Input/Output devices

1. **DPI**

   Get actual size of the screen in `mm`.

   ```sh
   $ xrandr | grep -w connected
   eDP1 connected primary 1920x1080+0+0 (normal left inverted right x axis y axis) 340mm x 190mm
   ```

   Edit `/etc/X11/xorg.conf.d/70-monitor.conf`

   ```sh
   Section "Monitor"
     Identifier  "<default monitor>"
     DisplaySize 340 190
   EndSection
   ```

   Logout and check current DPI.

   ```sh
   xdpyinfo | grep -B2 resolution
   ```

   Place this in `~/.profile` to fix QT scaling:

   ```sh
   export QT_FONT_DPI=96
   ```

2. **Keyboard**

3. **Touchpads**

   ```sh
   sudo apt install xserver-xorg-input-libinput
   sudo apt purge xserver-xorg-input-synaptics
   ./scripts/configs/touchpad.sh
   ```

4. **Brightness controls**

   ```sh
   sudo apt install xbacklight
   ```

   Check if `sys/class/backlight/intel_backlight` directory exists. If not, run
   the following command:

   ```sh
   $ sudo find /sys/ -type f -iname '*brightness*'

   /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/actual_brightness
   /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/brightness
   /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/max_brightness
   ```

   Link the devices to `/sys/class/backlight/`

   ```sh
   sudo ln -s /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight  /sys/class/backlight/intel_backlight
   ```

   Create file `/etc/X11/xorg.conf.d/80-intel-backlight.conf` with the following
   content

   ```sh
   Section "Device"
     Identifier  "Intel Graphics"
     Driver      "intel"
     Option      "Backlight"  "intel_backlight"
   EndSection
   ```

   Logout and login again.

## Networking

1. **Clock synchronization**

2. **Internet**

3. **Bluetooth**

4. Browser

   - Google Chrome

   ```sh
   wget -O Chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
   sudo gdebi Chrome.deb
   ```

## Power Management

1. **TLP**

   ```sh
   sudo apt install -t buster-backports tlp tlp-rdw
   sudo tlp start
   tlp-stat -s # check that TLP is enabled and active
   ```

2. **Power button action configuration**

   Edit `/etc/systemd/logind.conf` and uncomment the line
   `#HandlePowerKey=poweroff`. Possible other actions are `ignore`, `reboot`,
   `halt`, `suspend`, `hibernate`, `lock`. You can also change the default
   actions when closing lid.

   ```sh
   HandlePowerKey=ignore
   #HandleSuspendKey=suspend
   #HandleHibernateKey=hibernate
   #HandleLidSwitch=suspend
   #HandleLidSwitchExternalPower=suspend
   #HandleLidSwitchDocked=ignore
   #PowerKeyIgnoreInhibited=no
   #SuspendKeyIgnoreInhibited=no
   #HibernateKeyIgnoreInhibited=no
   #LidSwitchIgnoreInhibited=yes
   ```

## Multimedia

1. **Sound**

   ```sh
     sudo apt install --no-install-recommends pulseaudio alsa-utils
   ```

2. **Codecs**

3. **Video**

## Appearance

1. **Fonts**

   ```sh
   sudo apt install fontconfig
   ```

   Install fonts including custom JetBrains Mono Nerd font.

   ```sh
   ./scripts/desktop_environment/fonts.sh
   fc-cache -fv # rebuild cached list of fonts
   ```

2. Emoji Fonts

3. **GTK and Qt Themes**

## Application

### CLI

1. Clipboard

   ```sh
   sudo apt install xclip
   ```

2. File Manager: _ranger_

   ```sh
   pipx install ranger-fm

   # image previews
   pipx install ueberzug

   ```

### GUI

1. **VS Code**

   ```sh
   sudo update-alternatives --config editor
   ```

## System administration

1. **Service management**

2. **System monitors**

   - Conky
   - Htop
   - lm-sensors
   - neofetch

3. **Security**

   - Enable insults in `sudo` when entering an incorrect password by editting
     `/etc/sudoers/01_insults`

   ```
   Defaults insults
   ```

   - DNS security
   - Firewall

4. **Package manager**

5. **Backup**

   - List of installed packages

6. **Mount**

7. **Clean the filesystems**

   - Disk usage display
   - Disk cleaning
   - Old configurations files
   - Broken symlinks

## Improving Performance

## Installation

- Fix missing firmware in `/lib/firmware/i915`

  ```sh
  sudo apt install firmware-misc-nonfree
  ```

The following step can be skipped since it is my personal configs.

## More configurations

- [notes](./configurations.md)

```

```
