#!/usr/bin/env bash

assert() {
  if [ ! $? -eq 0 ]; then
    fail "error: $1 fail"
    errors+=("$1")
  fi
}

test() {
  local case=$1
  shift

  local command=("$@")
  local command=$(printf " && %s" "${command[@]}")
  local command=${command:4}

  info "${case}: ${command}"

  docker run -it --rm "$IMAGE_NAME" \
    bash -c "$command"

  assert "${case}"
  echo
}

summary() {
  if [ ${#errors[@]} -eq 0 ]; then
    success "No errors!"
  else
    fail "Errors Summary:"
    printf "  > ${fg_red}%s${ta_normal}\n" "${errors[@]}"
  fi
}
