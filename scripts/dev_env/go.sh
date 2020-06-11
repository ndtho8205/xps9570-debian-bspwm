#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION] -i INSTALLATION_DIR -v GO_VERSION

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

  if [ -z "$installation_dir" ]; then
    echo "error: the following arguments are required: -i INSTALLATION_DIR"
    exit 1
  fi

  if [ -z "$go_version" ]; then
    echo "error: the following arguments are required: -v GO_VERSION"
    exit 1
  fi

}

setup_go() {
  local go_installation_dir="${1}/go"
  local go_version="${2}"

  wget -O go.tar.gz "https://dl.google.com/go/go${go_version}.linux-amd64.tar.gz"

  tar -C "$go_installation_dir" -xzf go.tar.gz
}

if ! (return 0 2>/dev/null); then
  installation_dir=
  go_version=

  _parse_params "$@"
  setup_go "$installation_dir" "$go_version"

  unset installation_dir
  unset go_version
fi
