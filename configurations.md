# Configurations

- **GitHub and GitLab SSH keys**

  ```sh
  ./scripts/configs/git.sh
  ssh -Tv git@github.com    # <--- check ssh connections
  ssh -Tv git@gitlab.com
  ```

- **XDG user directories**

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

- **Sound**

  ```sh
  sudo apt install --no-install-recommends pulseaudio alsa-utils
  ```

- **Brightness controls**

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

  ```
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

- **Touchpad**

  ```sh
  sudo apt install xserver-xorg-input-libinput
  sudo apt purge xserver-xorg-input-synaptics
  ./scripts/configs/touchpad.sh
  ```

- Config multi-touch gesture

- Improve battery life

  ```sh
  sudo apt install tlp tlp-rdw powertop
  sudo tlp start
  sudo powertop --auto-tune
  # sudo systemctl enable powertop
  sudo reboot
  ```
