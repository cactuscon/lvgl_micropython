#!/bin/bash
# build_and_run.sh: Build Docker image, run container, and collect ESP32 build outputs
set -e

IMAGE_NAME=cc-lvgl_micropython-esp32
CONTAINER_NAME=cc-lvgl_micropython-esp32-build
WORKSPACE_DIR=$(pwd)
BUILD_DIR="$WORKSPACE_DIR/build"

# Build Docker image
DOCKER_BUILDKIT=1 docker build -t $IMAGE_NAME:latest .

# Ensure build output directory exists
mkdir -p "$BUILD_DIR"

#
# To use a local ESP-IDF, set the IDF_PATH environment variable and optionally mount it:
#   export IDF_PATH=/path/to/esp-idf
#   docker run ... -e IDF_PATH=$IDF_PATH -v $IDF_PATH:$IDF_PATH ...
#
# The script will export IDF_PATH and update PATH if provided.

docker run --rm \
  --name $CONTAINER_NAME \
  -v "$BUILD_DIR:/workspace/build" \
  $IMAGE_NAME:latest

echo "Build complete. Output files are in ./build."
