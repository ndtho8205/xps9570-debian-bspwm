# After installation

- Verify UEFI boot mode

  `ls /sys/firmware/efi/efivars` should exist and return a bunch of files

  `bootctl`

- Verify the system clock

  `timedatectl status`

  `timedatectl set-ntp true`

- Verify existing drive setup

  `lsblk`

- XDG user directories

  `sudo apt install xdg-user-dirs && xdg-user-dirs-update` to create default
  user directories (e.g. Desktop, Downloads) within `$HOME` directory. It also
  create a local configuration file `~/.config/user-dirs.dirs`

- Automatically recognize USB devices

- Find application name

  `xprop | grep WM_CLASS`

- Computer doesn't restart/logout: `nouveau.modeset = 0`
- Audio
- Network management

  ```sh
  sudo apt install networkmanager
  systemctl status NetworkManager
  nmtui
  nmcli
  ```

- Killer WiFi 1650 card
- Touchpad, multi-touch gesture

  ```sh
  sudo apt-get install xserver-xorg-input-libinput
  sudo apt-get remove --purge xserver-xorg-input-synaptics
  sudo reboot
  ```

- Improve battery life

  ```sh
  sudo apt update
  sudo apt install tlp tlp-rdw powertop
  sudo tlp start
  sudo powertop --auto-tune
  sudo reboot
  ```

- Bluetooth
- Screen brightness
- Keyboard backlight
- NVIDIA Drivers
- Fingerprint reader
- Thunderbolt
