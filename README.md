# xps9570-debian-bspwm

Experiences of Debian with bspwm tiling window manager installation on my Dell XPS 15 9570.

## TODO

- [ ] Debian + Desktop enviroment installation (WIP)
  - Working on virtual machine before installing on the real computer
  - Check my notes in `Debian with bspwm Installation` section
- [ ] Before installation: docs
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

## Configuration

- Killer 1535-chip and Intel 9260-chip

| -          | -                                  |
| ---------- | ---------------------------------- |
| CPU        | Intel Core i7-8750H CPU @ 2.20 GHz |
| RAM        | 16GB                               |
| HDD        |                                    |
| Video card | Nvidia GeForce GTX 1050 Ti         |
| Screen     | FullHD non-touch                   |
| Wifi       | Killter 1535                       |
| Battery    | Dell SMP GPM0365 423  97Whr        |
| Touchpad   |                                    |

- `lspci` output:

```
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

- [notes](./before-installation.md)

## Debian with bspwm Installation

- [notes](./installation.md)

## After installation

- [notes](./after-installation.md)

## Credits

- [delta-one/dell-xps-15-9570-debian-linux](https://github.com/delta-one/dell-xps-15-9570-debian-linux)
