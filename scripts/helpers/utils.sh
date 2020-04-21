#!/usr/bin/env bash

ta_normal='' ta_standout=''
fg_blue='' fg_red='' fg_green=''

ncolors=$(command -v tput >/dev/null && tput colors)
if test -n "$ncolors" && test "$ncolors" -ge 8; then
  ta_normal="$(tput sgr0)"
  ta_standout="$(tput smso)"

  fg_blue="$(tput setaf 4)"
  fg_red="$(tput setaf 1)"
  fg_green="$(tput setaf 2)"
fi

info() {
  printf "\n${ta_standout}${fg_blue} INFO ${ta_normal} ${fg_blue}%s${ta_normal}\n" "$1"
}

success() {
  printf "\n${ta_standout}${fg_green} DONE ${ta_normal} ${fg_green}%s${ta_normal}\n" "$1"
}

fail() {
  printf "\n${ta_standout}${fg_red} FAIL ${ta_normal} ${fg_red}%s${ta_normal}\n" "$1"
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
