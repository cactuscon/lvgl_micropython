# Local validation image for the ESP32_GENERIC_S3 SPIRAM_OCT 8MB profile.
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv \
    git wget curl make gcc g++ flex bison gperf \
    cmake ninja-build ccache libffi-dev libssl-dev \
    dfu-util libusb-1.0-0 \
    python3-serial python3-click python3-cryptography python3-future python3-pyparsing python3-pyelftools \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /workspace

# The build context is the checked-out repository. Initialise precisely the
# submodules needed by the ESP32-S3 build, matching the release workflow.
COPY . /workspace
RUN git submodule update --init --depth 1 -- lib/pycparser lib/micropython lib/lvgl lib/esp-idf \
    && cd lib/esp-idf \
    && git submodule update --init --depth 1 -- components/bt/host/nimble/nimble components/esp_wifi components/esptool_py/esptool components/lwip/lwip components/mbedtls/mbedtls components/bt/controller/lib_esp32 components/bt/controller/lib_esp32c3_family \
    && ./install.sh esp32s3

ENV IDF_PATH=/workspace/lib/esp-idf

# This is the local representative build from the fork's four-job S3 profile.
ENTRYPOINT ["/bin/bash", "-lc", ". \"$IDF_PATH/export.sh\" && exec python3 make.py esp32 BOARD=ESP32_GENERIC_S3 BOARD_VARIANT=SPIRAM_OCT --flash-size=8 DISPLAY=rgb_display DISPLAY=st7796 DISPLAY=st7789 DISPLAY=st7735 DISPLAY=ili9488 DISPLAY=ili9486 DISPLAY=ili9481 DISPLAY=ili9341 DISPLAY=ili9225 DISPLAY=ili9163 DISPLAY=gc9a01 INDEV=xpt2046 INDEV=gt911 INDEV=ft6x36 INDEV=ft6x06 INDEV=ft5x16 INDEV=ft5x06"]
