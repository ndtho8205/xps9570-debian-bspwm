# xps9570-debian-bspwm

Experiences of Debian with bspwm tiling window manager installation on my Dell
XPS 9570.

## TODO

- [x] Before installation: steps + docs
- [ ] Debian + Desktop enviroment installation (WIP)
  - Working on virtual machine before installing on the real computer
  - Check my notes in `Debian with bspwm Installation` section
- [ ] After installation: apps + tools + docs

## My XPS 9570 Specifications

| Specification            | Detail                                            | Kernel Driver | Status             |
| ------------------------ | ------------------------------------------------- | ------------- | ------------------ |
| CPU                      | Intel Core i7-8750H CPU                           |               | :heavy_check_mark: |
| Memory                   | 16GB DDR4-2666MHz                                 |               | -                  |
| Storage                  | 512GB PCIe NMVe SSD                               |               | -                  |
| Keyboard                 | Backlit keyboard                                  |               | -                  |
| Touchpad                 | Multi-touch gesture support                       |               | -                  |
| Battery                  | 6-cell lithium ion (97WHr)                        |               | -                  |
| Fingerprint reader       | Goodix Fingerprint Sensor Driver                  |               | -                  |
| **Display**              |                                                   |               |                    |
| Screen                   | 15.6-inch FHD non-touchscreen                     |               | -                  |
| Integrated Video card    | Intel UHD Graphics 630                            |               | -                  |
| Discrete Video card      | NVIDIA GeForce GTX 1050 Ti 4GB GDDR5              |               | -                  |
| **Communications**       |                                                   |               |                    |
| Wifi & Bluetooth         | Killer 1535 802.11ac 2x2 Wifi & Bluetooth 4.2     |               | -                  |
| Speakers                 | ALC3266-CG with Waves MaxxAudio Pro               |               | -                  |
| Microphone               | Dual-array microphones                            |               | -                  |
| Webcam                   | Widescreen HD (720p)                              |               | -                  |
| **Ports and Connectors** |                                                   |               |                    |
| USB 3.0                  | Two USB 3.1 Gen 1 ports with PowerShare           |               | -                  |
| Thunderbolt 3            | One port with Power delivery                      |               | -                  |
| Video                    | One HDMI 2.0 port                                 |               | -                  |
| Audio                    | One headset (headphone and microphone combo) port |               | -                  |
| Media-card reader        | SD card, SD High Capacity, SD Extended capacity   |               | -                  |

`lspci -knn` output:

<details>
<summary>click to expand</summary>

```sh
00:00.0 Host bridge [0600]: Intel Corporation 8th Gen Core Processor Host Bridge/DRAM Registers [8086:3ec4] (rev 07)
  Subsystem: Dell Device [1028:087c]
00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07)
  Kernel driver in use: pcieport
00:02.0 VGA compatible controller [0300]: Intel Corporation Device [8086:3e9b]
  Subsystem: Dell Device [1028:087c]
  Kernel driver in use: i915
  Kernel modules: i915
00:04.0 Signal processing controller [1180]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903] (rev 07)
  Subsystem: Dell Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [1028:087c]
  Kernel driver in use: proc_thermal
  Kernel modules: processor_thermal_device
00:08.0 System peripheral [0880]: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th Gen Core Processor Gaussian Mixture Model [8086:1911]
  Subsystem: Dell Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th Gen Core Processor Gaussian Mixture Model [1028:087c]
00:12.0 Signal processing controller [1180]: Intel Corporation Cannon Lake PCH Thermal Controller [8086:a379] (rev 10)
  Subsystem: Dell Device [1028:087c]
  Kernel driver in use: intel_pch_thermal
  Kernel modules: intel_pch_thermal
00:14.0 USB controller [0c03]: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller [8086:a36d] (rev 10)
  Subsystem: Dell Device [1028:087c]
  Kernel driver in use: xhci_hcd
00:14.2 RAM memory [0500]: Intel Corporation Cannon Lake PCH Shared SRAM [8086:a36f] (rev 10)
  Subsystem: Dell Device [1028:087c]
00:15.0 Serial bus controller [0c80]: Intel Corporation Device [8086:a368] (rev 10)
  Subsystem: Dell Device [1028:087c]
  Kernel driver in use: intel-lpss
  Kernel modules: intel_lpss_pci
00:15.1 Serial bus controller [0c80]: Intel Corporation Device [8086:a369] (rev 10)
  Subsystem: Dell Device [1028:087c]
  Kernel driver in use: intel-lpss
  Kernel modules: intel_lpss_pci
00:16.0 Communication controller [0780]: Intel Corporation Cannon Lake PCH HECI Controller [8086:a360] (rev 10)
  Subsystem: Dell Device [1028:087c]
  Kernel driver in use: mei_me
  Kernel modules: mei_me
00:17.0 SATA controller [0106]: Intel Corporation Device [8086:a353] (rev 10)
  Subsystem: Dell Device [1028:087c]
  Kernel driver in use: ahci
  Kernel modules: ahci
00:1b.0 PCI bridge [0604]: Intel Corporation Device [8086:a340] (rev f0)
  Kernel driver in use: pcieport
00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:a338] (rev f0)
  Kernel driver in use: pcieport
00:1c.4 PCI bridge [0604]: Intel Corporation Device [8086:a33c] (rev f0)
  Kernel driver in use: pcieport
00:1d.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port 9 [8086:a330] (rev f0)
  Kernel driver in use: pcieport
00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:a30e] (rev 10)
  Subsystem: Dell Device [1028:087c]
00:1f.3 Audio device [0403]: Intel Corporation Cannon Lake PCH cAVS [8086:a348] (rev 10)
  Subsystem: Dell Device [1028:087c]
  Kernel driver in use: snd_hda_intel
  Kernel modules: snd_hda_intel
00:1f.4 SMBus [0c05]: Intel Corporation Cannon Lake PCH SMBus Controller [8086:a323] (rev 10)
  Subsystem: Dell Device [1028:087c]
  Kernel modules: i2c_i801
00:1f.5 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH SPI Controller [8086:a324] (rev 10)
  Subsystem: Dell Device [1028:087c]
01:00.0 3D controller [0302]: NVIDIA Corporation GP107M [GeForce GTX 1050 Ti Mobile] [10de:1c8c] (rev a1)
  Kernel modules: nvidiafb, nouveau, nvidia_drm, nvidia
3b:00.0 Network controller [0280]: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter [168c:003e] (rev 32)
  Subsystem: Bigfoot Networks, Inc. QCA6174 802.11ac Wireless Network Adapter [1a56:1535]
  Kernel driver in use: ath10k_pci
  Kernel modules: ath10k_pci
3c:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader [10ec:525a] (rev 01)
  Subsystem: Dell RTS525A PCI Express Card Reader [1028:087c]
  Kernel driver in use: rtsx_pci
  Kernel modules: rtsx_pci
3d:00.0 Non-Volatile memory controller [0108]: Toshiba America Info Systems Device [1179:0116]
  Subsystem: Toshiba America Info Systems Device [1179:0001]
  Kernel driver in use: nvme
```

</details>

## Functionality

| Category              | Functionality                     | Status |
| --------------------- | --------------------------------- | ------ |
| **Display**           |                                   |        |
|                       | Display brightness                | -      |
| **Multiple monitors** |                                   |        |
|                       | HDMI                              | -      |
|                       | Audio on HDMI                     | -      |
| **Keyboard**          |                                   |        |
|                       | Keyboard backlight                | -      |
|                       | Fn/Multimedia keys                | -      |
| **Communications**    |                                   |        |
|                       | Audio                             | -      |
|                       | Bluetooth headphones              | -      |
|                       | rfkill                            | -      |
| **Power management**  |                                   |        |
|                       | Suspend                           | -      |
|                       | Hibernate                         | -      |
|                       | AC power management               | -      |
|                       | Battery power management          | -      |
| **NVIDIA Video card** |                                   |        |
|                       | Hybrid Graphics                   | -      |
|                       | Nvidia/Intel graphic cards switch | -      |
|                       | Sleep/wake on Nvidia              | -      |
|                       | Sleep/wake on Intel               | -      |

## Before installation

These steps help to install Debian alongside Windows 10 (dual-booting)

- The System BIOS should be updated to the latest version
- **Do not** turn off BIOS POST Behaviour `FastBoot` (by changing from the
  default value `minimal` to `thorough`). Instead, Windows _fast startup_
  **_must_** be turned off, or the Windows filesystems might be corrupted when
  booting to Debian and accessing Windows partitions
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
  driver in the image)

## Debian with bspwm Installation

- [notes](./installation.md)

## After installation

- [notes](./after-installation.md)

## Credits

- [Arch Linux Wiki](https://wiki.archlinux.org/index.php/Dell_XPS_15_9570)
- [delta-one/dell-xps-15-9570-debian-linux](https://github.com/delta-one/dell-xps-15-9570-debian-linux)
