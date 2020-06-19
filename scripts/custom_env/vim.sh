#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

VIM_LATEST_VERSION="8.2.1009"

_print_usage() {
  cat <<EOF
usage: $(basename "$0") [OPTION]

Options:
  -v VERSION     The version of vim to install.
                 Default: $VIM_LATEST_VERSION
  -h, --help     Show this help and exit

EOF
}

_parse_params() {
  local param
  version="$VIM_LATEST_VERSION"

  while [[ $# -gt 0 ]]; do
    param="$1"
    shift

    case $param in
    -v)
      version=$1
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

_build_vim() {
  apt-get install -y \
    libncurses5-dev libgtk-3-dev libatk1.0-dev libcairo2-dev \
    libx11-dev libxpm-dev libxt-dev \
    python3-dev \
    lua5.2 liblua5.2-dev libperl-dev # ruby-dev \

  git clone https://github.com/vim/vim.git
  cd vim
  git checkout "v$version"

  ./configure \
    --with-features=huge \
    --enable-multibyte \
    --enable-python3interp=yes \
    --with-python3-config-dir=$(python3-config --configdir) \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-gui=gtk3 \
    --enable-cscope \
    --prefix=/usr
  # --enable-rubyinterp=yes \

  make VIMRUNTIMEDIR=/usr/share/vim/vim82
}

_make_vim_deb() {
  checkinstall \
    --type=debian \
    --install=no \
    --fstrans=no \
    --default \
    --pkgversion="$version" \
    --requires="libacl1,libc6,libcairo2,libgdk-pixbuf2.0-0,libglib2.0-0,libgpm2,libgtk-3-0,libice6,liblua5.2-0,libpango-1.0-0,libpangocairo-1.0-0,libperl5.28,libpython3.7,libselinux1,libsm6,libtcl8.6,libtinfo6,libx11-6,libxt6" \
    --pakdir="../build"
  #libruby2.5,
}

if ! (return 0 2>/dev/null); then
  _parse_params "$@"

  _build_vim
  _make_vim_deb

  unset version
fi
