# Building Custom Environment

- Fix missing firmware in `/lib/firmware/i915`

  ```sh
  sudo apt install firmware-misc-nonfree
  ```

- Display server: _Xorg_

  ```sh
  sudo apt install xorg
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

  It is important to have `bspwm` and `sxhkd` configs in the right place. You
  can create the default configs for them as follows:

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
