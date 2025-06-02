FROM arm64v8/ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    software-properties-common \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    libudev-dev \
    libsdl2-dev \
    libpulse-dev \
    libgl1-mesa-dev \
    libasound2-dev \
    retroarch \
    && apt clean

# Install Mupen64Plus (via libretro core)
RUN retroarch --download "Mupen64Plus-Next"

# Create ROM folder
RUN mkdir /roms

VOLUME ["/roms"]

ENTRYPOINT [ "retroarch" ]
