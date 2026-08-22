#!/bin/bash
# Build the local ESP32-S3 SPIRAM_OCT 8MB validation image and collect output.
set -euo pipefail

IMAGE_NAME=cc-lvgl_micropython-esp32
CONTAINER_NAME=cc-lvgl_micropython-esp32-build
WORKSPACE_DIR=$(cd -- "$(dirname -- "$0")" && pwd)
BUILD_DIR="$WORKSPACE_DIR/build"

# Build the self-contained image from the repository root.
docker build -t "$IMAGE_NAME:latest" "$WORKSPACE_DIR"

# Ensure build output directory exists
mkdir -p "$BUILD_DIR"

docker run --rm \
  --name "$CONTAINER_NAME" \
  -v "$BUILD_DIR:/workspace/build" \
  "$IMAGE_NAME:latest"

echo "Build complete. Output files are in ./build."
