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

* Find application name

  `xprop | grep WM_CLASS`

* Computer doesn't restart/logout: `nouveau.modeset = 0`
* Kernel boot parameters

  ```
  GRUB_CMDLINE_LINUX_DEFAULT="quiet nouvea.modeset=0 nogpumanager pcie_aspm=off acpi_backlight=none acpi_osi=Linux acpi_osi=!"
  systemd.mask=mhwd-live.service
  acpi_rev_override=1

  # for fixing power management of the intel graphics
  i915.i915_enable_rc6=1 i915.i915_enable_fbc=1 i915.lvds_downclock=1 i915.i915_psr=1 drm.vblankoffdelay=1

  ```

* Network management

  ```sh
  sudo apt install networkmanager
  systemctl status NetworkManager
  nmtui
  nmcli
  ```

  - Disable random MAC addresses by appending the following to
    `/etc/NetworkManager/NetworkManager.conf`:

    ```sh
    [device]
    wifi.scan-rand-mac-address=no
    ```

  - Restart NetworkManager service

* Touchpad, multi-touch gesture

  ```sh
  sudo apt-get install xserver-xorg-input-libinput
  sudo apt-get remove --purge xserver-xorg-input-synaptics
  sudo reboot
  # add 90-touchpad.conf to /etc/X11/xorg.conf.d/
  ```

* Improve battery life

  ```sh
  sudo apt update
  sudo apt install tlp tlp-rdw powertop
  sudo tlp start
  sudo powertop --auto-tune
  # sudo systemctl enable powertop
  sudo reboot
  ```

* Set DPI, anti-aliasing, hinting

  ```shell
  $ xrdb -query -all

  *customization:	-color
  Xft.dpi:	96
  Xft.antialias:	1
  Xft.hinting:	1
  Xft.hintstyle:	hintslight
  Xft.rgba:	none
  Xcursor.size:	24
  Xcursor.theme:	DMZ-White
  ```
