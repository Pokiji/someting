FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
    retroarch \
    x11vnc \
    xvfb \
    websockify \
    supervisor \
    wget \
    unzip \
    python3 \
    && apt clean

# Create noVNC folder and download it
RUN mkdir -p /opt/novnc/utils/websockify /opt/novnc/utils/websockify/vendor \
    && wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz \
       | tar xz --strip-components=1 -C /opt/novnc \
    && wget -qO- https://github.com/novnc/websockify/archive/refs/tags/v0.10.0.tar.gz \
       | tar xz --strip-components=1 -C /opt/novnc/utils/websockify

# Create folder for ROMs
RUN mkdir /roms

VOLUME ["/roms"]

# Copy supervisord config
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Xvfb fake display on :1, VNC on 5901, websockify/noVNC on 6080
EXPOSE 5901 6080

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
