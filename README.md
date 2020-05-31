# xps9570-debian-bspwm

Experiences of Debian with bspwm tiling window manager installation on my Dell
XPS 9570.

## TODO

### Overall

- [x] Before installation: steps + docs
- [ ] Debian + Desktop enviroment installation
  - [x] on virtual machine
  - [ ] on the real computer
- [ ] After installation: apps + tools + docs

### Desktop environment installation

- [x] Terminal Emulator
- [x] Dotfiles
- [x] Display server
- [x] Display manager
- [x] Tiling window manager
- [x] Shell
- [x] Notification
- [x] Application launcher
- [x] Network manager
- [x] Touchpad
- [x] Volume control
- [x] Backlight control
- [ ] Screen locker

## Table of contents

- [xps9570-debian-bspwm](#xps9570-debian-bspwm)
  - [TODO](#todo)
  - [Table of contents](#table-of-contents)
  - [My XPS 9570 Specifications](#my-xps-9570-specifications)
  - [Functionality](#functionality)
  - [Requirements](#requirements)
  - [Before installation](#before-installation)
  - [Debian Installation](#debian-installation)
  - [Things To Do Right After Installation](#things-to-do-right-after-installation)
  - [Install Desktop Environment](#install-desktop-environment)
  - [More configurations](#more-configurations)
  - [More softwares](#more-softwares)
  - [Credits](#credits)

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

| Category              | Functionality                                                | Status |
| --------------------- | ------------------------------------------------------------ | ------ |
|                       | Encryption                                                   | -      |
| **Display**           |                                                              |        |
|                       | Display brightness                                           | -      |
|                       | Lock screen                                                  | -      |
|                       | Set DPI                                                      | -      |
|                       | Anti-aliasing, hinting                                       | -      |
| **Multiple monitors** |                                                              |        |
|                       | HDMI                                                         | -      |
|                       | Audio on HDMI                                                | -      |
| **Keyboard**          |                                                              |        |
|                       | Keyboard backlight                                           | -      |
|                       | Fn/Multimedia keys                                           | -      |
| **Ports**             |                                                              | -      |
|                       | Automatically recognize USB devices                          | -      |
|                       | Automatically mount USB devices                              | -      |
| **Communications**    |                                                              |        |
|                       | Audio                                                        | -      |
|                       | Bluetooth headphones                                         | -      |
|                       | rfkill                                                       | -      |
| **Power management**  |                                                              |        |
|                       | Suspend                                                      | -      |
|                       | Suspend on closing lid                                       | -      |
|                       | Hibernate                                                    | -      |
|                       | AC power management                                          | -      |
|                       | Battery power management                                     | -      |
| **NVIDIA Video card** |                                                              |        |
|                       | Driver                                                       | -      |
|                       | Hybrid Graphics/On-demand `bumblebee`, `bbswitch`, `optirun` | -      |
|                       | Nvidia/Intel graphic cards switch                            | -      |
|                       | Sleep/wake on Nvidia                                         | -      |
|                       | Sleep/wake on Intel                                          | -      |

## Requirements

- Wifi connection
- 8GB USB
- Windows 10 have been already installed

## Before installation

These steps help to install Debian alongside Windows 10 (dual-booting)

- The System BIOS should be updated to the latest version.
- **Do not** turn off BIOS POST Behaviour `FastBoot` (by changing from the
  default value `minimal` to `thorough`). Instead, Windows _fast startup_
  **_must_** be turned off, or the Windows filesystems might be corrupted when
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
- Disable _Secure Boot_ to allow Debian to boot and prevent Nvidia card
  problems.
- Download the Debian DVD installation image (ISO file). The **complete** image
  should be used to make the installation easier later without an Internet
  connection. Download links:
  [using BitTorrent](https://cdimage.debian.org/debian-cd/current/amd64/bt-dvd/)
  or [using HTTP](https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/).
- Create a bootable USB using the downloaded image (using
  [Rufus](https://rufus.ie/) is highly recommended).
- WiFi networks cannot be detected during the Debian installation due to the
  lack of non-free firmware in the image. Thus, the firmware has to be manually
  downloaded at
  [this link](https://packages.debian.org/buster/firmware-atheros). Then, copy
  the downloaded `firmware-atheros_*.deb` file to the `firmware` directory in
  the USB drive.

We are good to go!

## Debian Installation

- Carefully follow the installation instructions.
- _Detect network hardware_: A warning message may appear (missing firmware file
  `ath10k/pre-cal-pci-000`). Just ignore since it won't affect the network
  connection. The installation will connect to the WiFi successfully.
- _Software selection_: choose only `standard system utilitites`.
- Finish the installation and reboot to Debian. Since we did not install any
  desktop environment, a terminal will be showed instead.
- Login with your username and password.

## Things To Do Right After Installation

- Switch to `root` account to run commands

  ```sh
  su -
  ```

- Config `apt` to get and install packages offline from the installation USB
  drive

  ```sh
  fdisk -l            # <--- find the USB partition,
                      #      for example: /dev/sda1
  mkdir /media/usb0
  mount /dev/sda1 /media/usb0
  echo "deb [trusted=yes] file:/media/usb0/ buster main contrib" > /etc/apt/sources.list
  apt update
  ```

- Install `sudo` using package from the USB drive

  ```sh
  apt install sudo
  usermod -aG sudo <your_username>
  ```

- Logout and login again
- Install `network-manager` and connect to the WiFi network

  ```sh
  sudo apt install network-manager
  sudo /etc/init.d/network-manager restart
  nmtui         # <--- connect to WiFi
  ```

- Now, we can remove `cdrom` and `/dev/usb0` sources and install packages using
  WiFi. Also add `contrib` and `non-free` components to `/etc/apt/sources.list`
  file. The file content should looks like this:

  ```sh
  deb http://deb.debian.org/debian buster main contrib non-free
  # deb-src http://deb.debian.org/debian buster main

  deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free
  # deb-src http://deb.debian.org/debian-security/ buster/updates main

  deb http://deb.debian.org/debian buster-updates main contrib non-free
  # deb-src http://deb.debian.org/debian buster-updates main
  ```

- Update and upgrade installed packages using WiFi network

  ```sh
  sudo apt update
  sudo apt upgrade
  ```

- Install some important packages

  ```sh
  sudo apt install wget curl gdebi-core unzip \
    fontconfig intel-microcode software-properties-common

  sudo apt install build-essential git tree # <--- you can skip this,
                                            #      if you were not a coder like me
  ```

- Reboot

  ```sh
  sudo reboot
  ```

## Install Desktop Environment

- Fix missing firmware in `/lib/firmware/i915`

  ```sh
  sudo apt install firmware-misc-nonfree
  ```

- Display server: _Xorg_

  ```sh
  sudo apt install xorg
  sudo apt install xserver-xorg-video-intel
  ```

- Display manager: _LightDM_

  ```sh
  sudo apt install lightdm
  ```

- Window manager: _bspwm_, _sxhkd_

  ```sh
  sudo apt install --no-install-recommends bspwm sxhkd
  ```

- Composite managers: _picom_
- Window switcher, run dialog: _rofi_

  ```sh
  sudo apt install rofi
  ```

- Desktop notifications: _dunst_

  ```sh
  sudo apt install dunst libnotify-bin
  ```

- Terminal Emulator: _Alacritty_

  ```sh
  wget -O Alacritty.deb https://github.com/alacritty/alacritty/releases/download/v0.4.2/Alacritty-v0.4.2-ubuntu_18_04_amd64.deb
  sudo gdebi Alacritty.deb
  ```

- Google Chrome

  ```sh
  wget -O Chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo gdebi Chrome.deb
  ```

The two following steps can be skipped since it is my personal configs.

- Install fonts including custom JetBrains Mono Nerd font.

  ```sh
  ./scripts/desktop_environment/fonts.sh
  ```

- Install my configs

  ```sh
  git clone https://github.com/ndtho8205/de-configs.git
  cd de-configs
  ./install.sh
  ```

It is important to have `bspwm` and `sxhkd` configs in the right place. You can
create the default configs for them as follows:

```
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
chmod +x ~/.config/bspwm/bspwmrc
```

- Reboot

Lightdm login screen will be showed this time. After login, press
<kbd>Windows</kbd> + <kbd>Enter</kbd> to open a terminal.

## More configurations

- [notes](./configurations.md)

## More softwares

- [notes](./softwares.md)
- [notes](./after-installation.md)

## Credits

- [Arch Linux Wiki](https://wiki.archlinux.org/index.php/Dell_XPS_15_9570)
- [delta-one/dell-xps-15-9570-debian-linux](https://github.com/delta-one/dell-xps-15-9570-debian-linux)
