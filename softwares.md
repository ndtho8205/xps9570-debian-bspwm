# More softwares

- Install `zsh`

  ```sh
  sudo apt install zsh
  chsh -s $(which zsh)
  ```

- Install `vim`

  ```sh
  sudo apt install vim-gtk3
  ```

- Install my dotfiles

  ```sh
  git clone git@github.com:ndtho8205/dotfiles.git
  cd dotfiles
  git submodule update --init --recursive
  ./install.sh
  ```

- Download and install Visual Studio Code from
  [this link](https://code.visualstudio.com/docs/?dv=linux64_deb)
