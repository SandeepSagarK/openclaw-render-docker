FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV PORT=8080

# Install system + GUI + VNC
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    libopenal-dev \
    libvorbis-dev \
    libglew-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    xvfb \
    fluxbox \
    x11vnc \
    websockify \
    novnc \
    python3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone OpenClaw
RUN git clone https://github.com/openclaw/openclaw.git

WORKDIR /app/openclaw

# Try build (safe fallback)
RUN make -j$(nproc) || true
RUN if [ -f engine/Makefile ]; then make -C engine -j$(nproc); fi

# noVNC setup
RUN ln -s /usr/share/novnc/vnc.html /app/index.html

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]