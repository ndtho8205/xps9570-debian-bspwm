#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
usage: $(basename "$0")

Options:
  -f, --force    Skip all user interaction. Implied 'Yes' to all actions
  -h, --help     Show this help and exit
EOF
}

_parse_params() {
  local param

  while [[ $# -gt 0 ]]; do
    param="$1"
    shift

    case $param in
    -i)
      installation_dir=$1
      shift
      ;;
    -v)
      go_version=$1
      shift
      ;;
    -f | --force)
      force=true
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

_uninstall_old_versions() {
  sudo apt purge docker docker-engine docker.io containerd runc
}

_install_dependencies() {
  sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"
}

setup_docker() {
  # _uninstall_old_versions

  _install_dependencies

  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io

  sudo groupadd docker
  sudo usermod -aG docker "$USER"

  sudo systemctl enable docker
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  setup_docker
fi
