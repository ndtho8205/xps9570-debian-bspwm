# Configurations

- **GitHub and GitLab SSH keys**

  ```sh
  ./scripts/configs/git.sh
  ssh -Tv git@github.com    # <--- check ssh connections
  ssh -Tv git@gitlab.com
  ```

- Intel Graphics card

  ```sh
   sudo apt install mesa-utils
   glxinfo | grep OpenGL
  ```

  If in the `OpenGL renderer string`, you see `llvmpipe`, that means the system
  doesn't use the GPU.

  3D acceleration: `glxinfo | grep rendering`

  Testing performance: `glxgears -info`

- [**NVIDIA Proprietary Driver**](https://wiki.debian.org/NvidiaGraphicsDrivers#Drivers)

  ```sh
  sudo apt install linux-headers-amd64
  ```

  Add `buster-backports` to `/etc/apt/sources.list` to install driver with
  latest version (440.82):

  ```sh
  deb http://deb.debian.org/debian buster-backports main contrib non-free
  ```

  Install package `nvidia-driver`:

  ```sh
  sudo apt update
  sudo apt install -t buster-backports nvidia-driver nvidia-smi
  ```

  Reboot to load the updated driver.

  BumbleBee

  Checking drivers:

  ```ssh
  glxinfo | grep OpenGL # for Intel
  optirun glxinfo | grep OpenGL # for NVIDIA

  glxgears -info # for Intel
  optirun glxgears -info # for NVIDIA
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

- NTFS

  ```sh
  sudo apt install ntfs-3g
  ```

- inotify

  ```sh
  sudo apt install inofity-tools
  echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p\
  ```

- Fix AppImage runs only with `--no-sandbox`
  ```
  echo "kernel.unprivileged_userns_clone=1" | sudo tee -a /etc/sysctl.d/00-local-userns.conf
  ```
