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

  Create default user directories:

  ```sh
  xdg-user-dirs-update
  ```

- Config audio

  ```sh
  sudo apt install --no-install-recommends pulseaudio alsa-utils
  ```
