# Configurations

- Config git (GitHub and GitLab SSH keys)

  ```sh
  ./scripts/configs/git.sh
  ssh -Tv git@github.com    # <--- check ssh connections
  ssh -Tv git@gitlab.com
  ```

- XDG user directories

  ```sh
  sudo apt install xdg-user-dirs
  ```

  Edit `~/.config/user-dirs.dirs` file as follow

  ```sh
  XDG_DOWNLOAD_DIR="$HOME/Downloads"
  XDG_TEMPLATES_DIR="$HOME/Templates"
  XDG_PUBLICSHARE_DIR="$HOME/Public"
  XDG_DOCUMENTS_DIR="$HOME/Documents"
  XDG_MUSIC_DIR="$HOME/"
  XDG_PICTURES_DIR="$HOME/Pictures"
  XDG_VIDEOS_DIR="$HOME/"
  XDG_DESKTOP_DIR="$HOME/"
  ```

  Create default user directories:

  ```sh
  xdg-user-dirs-update
  ```

- Config audio

  ```sh
  sudo apt install --no-install-recommends pulseaudio alsa-utils
  ```

- Config touchpad

  ```sh
  sudo apt install xserver-xorg-input-libinput
  sudo apt purge xserver-xorg-input-synaptics
  ./scripts/configs/touchpad.sh
  ```

- Config multi-touch gesture
