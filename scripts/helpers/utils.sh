#!/usr/bin/env bash

ta_normal=
fg_blue='' fg_red='' fg_green=''
bg_blue='' bg_red='' bg_green=''

ncolors=$(command -v tput >/dev/null && tput colors)
if test -n "$ncolors" && test "$ncolors" -ge 8; then
  ta_normal="$(tput sgr0)"

  fg_blue="$(tput setaf 4)"
  fg_red="$(tput setaf 1)"
  fg_green="$(tput setaf 2)"

  bg_blue="$(tput setab 4)"
  bg_red="$(tput setab 1)"
  bg_green="$(tput setab 2)"
fi

info() {
  printf "\n${bg_blue} INFO ${ta_normal} ${fg_blue}%s${ta_normal}\n" "$1"
}

success() {
  printf "\n${bg_green} DONE ${ta_normal} ${fg_green}%s${ta_normal}\n" "$1"
}

fail() {
  printf "\n${bg_red} FAIL ${ta_normal} ${fg_red}%s${ta_normal}\n" "$1"
}

check_run() {
  if [ $? -eq 0 ]; then
    success "$1"
  else
    fail "$1"
  fi
}

clrscr() {
  tput reset
}

source_file() {
  local sourceFile=$1

  if [ ! -f "${sourceFile}" ]; then
    echo "error: Can not find sourcefile '$sourceFile'."
    exit 1
  fi

  source "${sourceFile}"
}
