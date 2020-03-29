# xps9570-debian-bspwm

Experiences of Debian with bspwm tiling window manager installation on my Dell
XPS 9570.

## TODO

- [x] Before installation: steps + docs
- [ ] Debian + Desktop enviroment installation (WIP)
  - Working on virtual machine before installing on the real computer
  - Check my notes in `Debian with bspwm Installation` section
- [ ] After installation: apps + tools + docs

## Checklist for installation

- [ ] Wifi + Bluetooth
- [ ] Atheros Wifi
- [ ] Audio
- [ ] Audio on HDMI
- [ ] HDMI
- [ ] Nvidia/Intel graphic cards switch
- [ ] Keyboard backlight
- [ ] Display brightness
- [ ] Sleep/wake on Intel
- [ ] Sleep/wake on Nvidia
- [ ] Goodix Fingerprint sensor
- [ ] Bluetooth headphones
- [ ] Battery consumption
- [ ] Touchpad
- [ ] Fn-keys
- [ ] Sound

## My XPS 9570 Specifications

| -                     | -                                             |
| --------------------- | --------------------------------------------- |
| CPU                   | Intel Core i7-8750H CPU @ 2.20 GHz            |
| Memory                | 16GB DDR4-2666MHz                             |
| Storage               | 512GB PCIe NMVe SSD                           |
| Integrated Video card | Intel UHD Graphics 630                        |
| Discrete Video card   | NVIDIA® GeForce® GTX 1050Ti 4GB GDDR5         |
| Screen                | 15.6" FHD non-touchscreen                     |
| Wifi                  | Killer 1535 802.11ac 2x2 Wifi & Bluetooth 4.1 |
| Battery               | 97WHr                                         |
| Touchpad              | Multi-touch gesture support                   |
| Fingerprint Reader    | Goodix Fingerprint Sensor Driver              |

- `lspci` output:

  ```sh
  00:00.0 Host bridge: Intel Corporation 8th Gen Core Processor Host Bridge/DRAM Registers (rev 07)
  00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) (rev 07)
  00:02.0 VGA compatible controller: Intel Corporation Device 3e9b
  00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem (rev 07)
  00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th Gen Core Processor Gaussian Mixture Model
  00:12.0 Signal processing controller: Intel Corporation Cannon Lake PCH Thermal Controller (rev 10)
  00:14.0 USB controller: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller (rev 10)
  00:14.2 RAM memory: Intel Corporation Cannon Lake PCH Shared SRAM (rev 10)
  00:15.0 Serial bus controller [0c80]: Intel Corporation Device a368 (rev 10)
  00:15.1 Serial bus controller [0c80]: Intel Corporation Device a369 (rev 10)
  00:16.0 Communication controller: Intel Corporation Cannon Lake PCH HECI Controller (rev 10)
  00:17.0 SATA controller: Intel Corporation Device a353 (rev 10)
  00:1b.0 PCI bridge: Intel Corporation Device a340 (rev f0)
  00:1c.0 PCI bridge: Intel Corporation Device a338 (rev f0)
  00:1c.4 PCI bridge: Intel Corporation Device a33c (rev f0)
  00:1d.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port 9 (rev f0)
  00:1f.0 ISA bridge: Intel Corporation Device a30e (rev 10)
  00:1f.3 Audio device: Intel Corporation Cannon Lake PCH cAVS (rev 10)
  00:1f.4 SMBus: Intel Corporation Cannon Lake PCH SMBus Controller (rev 10)
  00:1f.5 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH SPI Controller (rev 10)
  01:00.0 3D controller: NVIDIA Corporation GP107M [GeForce GTX 1050 Ti Mobile] (rev a1)
  3b:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
  3c:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader (rev 01)
  3d:00.0 Non-Volatile memory controller: Toshiba America Info Systems Device 0116
  ```

## Before installation

These steps help to install Debian alongside Windows 10 (dual-booting)

- **Do not** turn off BIOS POST Behaviour `FastBoot` (by changing from the
  default value `minimal` to `thorough`). Instead, _Windows fast startup_
  **must** be turned off, or the Windows filesystems might be corrupted when
  booting to Debian and accessing Windows partitions.
- Change _SATA Operation mode_ from `RAID` to `AHCI` to allow Debian to detect
  the storage drive (NVMe SSD):
  - Run `cmd` as an admin (on Windows 10), then run
    `bcdedit /set {current} safeboot minimal`
  - Reboot. Press F2 to go to `System Configuration`
  - In the SATA option, select `AHCI`
  - Save and reboot to Windows 10
  - Run `cmd` as an admin, then run `bcdedit /deletevalue {current} safeboot`
  - Reboot
- Disable _Secure Boot_ to allow Debian to boot and prevent Nvidia card problems
- Create a bootable CD/USB using Debian installation image. The **complete**
  image should be used to make the installation easier without Internet
  connection (Debian won't detect WiFi networks due to the lack of non-free WiFi
  driver in the image).

## Debian with bspwm Installation

- [notes](./installation.md)

## After installation

- [notes](./after-installation.md)

## Credits

- [Arch Linux Wiki](https://wiki.archlinux.org/index.php/Dell_XPS_15_9570)
- [delta-one/dell-xps-15-9570-debian-linux](https://github.com/delta-one/dell-xps-15-9570-debian-linux)
