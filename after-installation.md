# After installation

- Verify UEFI boot mode

  `ls /sys/firmware/efi/efivars` should exist and return a bunch of files

  `bootctl`

- Verify the system clock

  `timedatectl status`

  `timedatectl set-ntp true`

- Verify existing drive setup

  `lsblk`

- Find application name

  `xprop | grep WM_CLASS`

- Computer doesn't restart/logout: `nouveau.modeset = 0`
- Kernel boot parameters

  ```
  GRUB_CMDLINE_LINUX_DEFAULT="quiet nouvea.modeset=0 nogpumanager pcie_aspm=off acpi_backlight=none acpi_osi=Linux acpi_osi=!"
  systemd.mask=mhwd-live.service
  acpi_rev_override=1

  # for fixing power management of the intel graphics
  i915.i915_enable_rc6=1 i915.i915_enable_fbc=1 i915.lvds_downclock=1 i915.i915_psr=1 drm.vblankoffdelay=1

  ```

- Network management

  - Disable random MAC addresses by appending the following to
    `/etc/NetworkManager/NetworkManager.conf`:

    ```sh
    [device]
    wifi.scan-rand-mac-address=no
    ```

  - Restart NetworkManager service

- Set anti-aliasing, hinting

- Bluetooth: bluetooth mouse, keyboard, headphones
  ```sh
  pacman -S pulseaudio-bluetooth
  systemctl enable bluetooth.service
  bluetoothctl
  ```
