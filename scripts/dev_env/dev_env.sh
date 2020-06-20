#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

main() {
  command=

  _parse_params "$@"

  if [[ "$command" == "install" ]]; then
    _install
  elif [[ "$command" == "update" ]]; then
    _update
  elif [[ "$command" == "list" ]]; then
    _list
  fi
}

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION] {install,update,list}

Commands:
  install        Install development environment
  update         Update all packages
  list           List installed packages
Options:
  -h, --help     Show this help and exit
EOF
}

_parse_params() {
  if [[ $# -eq 0 ]]; then
    _print_usage
    exit 1
  fi

  local param

  while [[ $# -gt 0 ]]; do
    param="$1"
    shift

    case $param in
    install)
      command="install"
      shift
      ;;
    update)
      command="update"
      shift
      ;;
    list)
      command="list"
      shift
      ;;
    -h | --help)
      _print_usage
      exit 0
      ;;
    *)
      echo "error: unrecognized arguments: $param"
      exit 1
      ;;
    esac
  done
}

_install() {
  :
}

_update() {
  :
}

_list() {
  :
}

##################################################
## Golang
##################################################

_install_go_env() {
  local go_installation_dir="${1}/go"
  local go_version="${2}"

  wget -O go.tar.gz "https://dl.google.com/go/go${go_version}.linux-amd64.tar.gz"

  tar -C "$go_installation_dir" -xzf go.tar.gz
}

##################################################
## Rust
##################################################

_install_rust_env() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

##################################################
## Node.js
##################################################

_install_node_env() {
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
  sudo apt install -y nodejs
}

##################################################
## Python
##################################################

_install_python_env() {
  sudo apt install -y --no-install-recommends \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

  curl https://pyenv.run | bash
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"

  pyenv install 3.6.10
  pyenv global 3.6.10 system

  pip install --upgrade pip

  pip install pipx

  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
}

##################################################
## CLI Tools
##################################################

_install_markdown() {
  npm i -g markdownlint-cli prettier
}

_install_shell() {
  sudo apt install shellcheck
  sudo apt install snapd
  sudo systemctl start snapd
  sudo snap install shfmt
}

main "$@"
