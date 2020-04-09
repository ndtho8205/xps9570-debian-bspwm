#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION]

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

_setup_git_ssh() {
  host=$1
  email=$2
  output_keyfile="$HOME/.ssh/id_rsa_$1"

  echo "Generating public/private rsa key pair for $host"
  echo -n "  New passphrase: "
  read -s -r passphrase

  mkdir -p $HOME/.ssh
  ssh-keygen \
    -t rsa -b 4096 \
    -C "$email" \
    -N "$passphrase" \
    -f "$output_keyfile" >/dev/null

  cat "${output_keyfile}.pub"
  ssh-add ~/.ssh/id_rsa
  ssh -T gh
}

setup_git() {
  _setup_git_ssh "bb" "ndtho8205@gmail.com"
  #_setup_git_ssh "github" "ndtho8205@gmail.com"
  #_setup_git_ssh "gitlab" "ndtho8205@gmail.com"
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"
  setup_git
fi
