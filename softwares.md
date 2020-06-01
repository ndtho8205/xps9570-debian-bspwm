# More Softwares

## CLI Tools

- **`zsh`**

  ```sh
  sudo apt install zsh
  chsh -s $(which zsh)
  ```

- **`vim`**

  ```sh
  sudo apt install vim-gtk3
  ```

- **My dotfiles**

  ```sh
  git clone git@github.com:ndtho8205/dotfiles.git
  cd dotfiles
  git submodule update --init --recursive
  ./install.sh
  ```

- **`feh`** to manage wallpaper and display images

  ```sh
  sudo apt install --no-install-recommends feh
  ```

- **`maim`** to take screenshot

  ```sh
  sudo apt install maim
  ```

- **`ibus`** and **`ibus-bamboo`** to type Vietnamse

  ```sh
  ./scripts/configs/ibus.sh
  ```

- **Docker**

  ```sh
  ./scripts/apps/docker.sh
  ```

- **Neofetch**

  ```sh
  sudo apt install --no-install-recommends neofetch
  ```

- **ranger**

  ```sh
  pipx install ranger-fm
  ```

## GUI Tools

- Download and install **Visual Studio Code** from
  [this link](https://code.visualstudio.com/docs/?dv=linux64_deb)

- Download and install **VirtualBox** from
  [this link](https://www.virtualbox.org/wiki/Downloads)
