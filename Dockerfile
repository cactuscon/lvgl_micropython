# Dockerfile for ESP32_GENERIC_S3 SPIRAM_OCT build (flash-size 8)
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


# ESP-IDF is expected to be available in the environment or mounted in the container.
# Set IDF_PATH and update PATH as needed when running the container.

# Set up workspace
WORKDIR /workspace

# Copy the entire repository into the container
COPY . /workspace

# Entrypoint for ESP32_GENERIC_S3 SPIRAM_OCT 8MB build
ENTRYPOINT ["python3", "make.py", "esp32", "BOARD=ESP32_GENERIC_S3", "--flash-size=8", "DISPLAY=rgb_display", "DISPLAY=st7796", "DISPLAY=st7789", "DISPLAY=st7735", "DISPLAY=ili9488", "DISPLAY=ili9486", "DISPLAY=ili9481", "DISPLAY=ili9341", "DISPLAY=ili9225", "DISPLAY=ili9163", "DISPLAY=gc9a01", "INDEV=xpt2046", "INDEV=gt911", "INDEV=ft6x36", "INDEV=ft6x06", "INDEV=ft5x16", "INDEV=ft5x06", "MICROPY_HW_ESP_NEW_I2C_DRIVER=1"]
