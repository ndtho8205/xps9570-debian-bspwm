#!/usr/bin/env bash

if test -t 1; then
  ncolors=$(which tput >/dev/null && tput colors)

  if test -n "$ncolors" && test "$ncolors" -ge 8; then
    STANDOUT="$(tput smso)"
    NORMAL="$(tput sgr0)"
    GREEN="$(tput setaf 2)"
    BLUE="$(tput setaf 4)"
    RED="$(tput setaf 1)"
  fi
fi

info() {
  printf "${STANDOUT}${BLUE} INFO ${NORMAL} ${BLUE}%s${NORMAL}\n" "$1"
}

success() {
  printf "${STANDOUT}${GREEN} DONE ${NORMAL} ${GREEN}%s${NORMAL}\n" "$1"
}

fail() {
  printf "${STANDOUT}${RED} FAIL ${NORMAL} ${RED}%s${NORMAL}\n" "$1"
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
