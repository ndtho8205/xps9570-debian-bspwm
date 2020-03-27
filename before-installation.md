# Before installation

These steps help to install Debian alongside Windows 10 (dual-booting)

- Change *SATA Operation mode* from `RAID` to `AHCI` to allow Debian to detect the storage drive (NVMe SSD):
  - Run `cmd` as an admin (on Windows 10), then run `bcdedit /set {current} safeboot minimal`
  - Reboot. Press F2 to go to `System Configuration`
  - In the SATA option, select `AHCI`
  - Save and reboot to Windows 10
  - Run `cmd` as an admin, then run `bcdedit /deletevalue {current} safeboot`
  - Reboot
- Disable *Secure Boot* to allow Debian to boot and prevent Nvidia card problems
- Debian ISO
