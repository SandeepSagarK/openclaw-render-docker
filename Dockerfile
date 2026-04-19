FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools + dependencies for OpenClaw
RUN apt-get update && apt-get install -y \
    git \
    cmake \
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
    wget \
    curl \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Create working dir
WORKDIR /app

# Clone OpenClaw repo
RUN git clone https://github.com/openclaw/openclaw.git

WORKDIR /app/openclaw

# Build OpenClaw
RUN mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc)

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Render expects a port
ENV PORT=8080
EXPOSE 8080

CMD ["/start.sh"]