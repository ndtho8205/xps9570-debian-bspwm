#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION]

Options:
  --test         Skip all user interaction including password input. For test only 
  -h, --help     Show this help and exit
EOF
}

_parse_params() {
  local param
  while [[ $# -gt 0 ]]; do
    param="$1"
    shift

    case $param in
    --test)
      test=true
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

  echo
  echo "Generating public/private rsa key pair for $output_keyfile"
  echo -n "New passphrase: "

  if [ -z ${test+false} ]; then
    read -s -r passphrase
  else
    passphrase=$(id -un)
  fi

  mkdir -p "$HOME/.ssh"
  ssh-keygen \
    -t rsa -b 4096 \
    -C "$email" \
    -N "$passphrase" \
    -f "$output_keyfile" >/dev/null

  echo
  echo
  echo Copy and paste the public key below into SSH settings
  echo Github: https://github.com/settings/keys
  echo Gitlab: https://gitlab.com/profile/keys
  echo "--------------------"
  cat "${output_keyfile}.pub"
  echo "^^^^^^^^^^^^^^^^^^^^"

  if [ -z "${test+false}" ]; then
    :
  else
    return 0
  fi

  echo
  echo Press Enter to continue...
  read -r
  echo
  echo Re-enter your passphrase to add the generated key to ssh-agent
  ssh-add "$output_keyfile"

}

setup_git() {
  eval "$(ssh-agent)"

  _setup_git_ssh "github" "ndtho8205@gmail.com"
  _setup_git_ssh "gitlab" "ndtho8205@gmail.com"
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"
  setup_git
fi
