#!/bin/bash

docker build \
  --tag de_build \
  --file Dockerfile .

docker run \
  -v "$PWD/build":/app/build -it \
  de_build \
  bash -c "$1"
