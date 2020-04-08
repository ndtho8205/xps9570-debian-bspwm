#!/usr/bin/env bash

IMAGE_NAME="bspwm_scripts_test"

echo "Building image"
docker build --force-rm --quiet --tag "$IMAGE_NAME" .

echo "Running command"
docker run -it --rm "$IMAGE_NAME" "$@"
