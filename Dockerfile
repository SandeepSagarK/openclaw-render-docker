FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
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
    wget \
    curl \
    nano \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo
RUN git clone https://github.com/openclaw/openclaw.git

WORKDIR /app/openclaw

# 🔧 FIX: No CMake → use Make system
RUN ls -la

# Try building using Makefile (safe approach)
RUN make -j$(nproc) || true

# If root make fails, try engine folder (common structure fix)
RUN if [ -f engine/Makefile ]; then make -C engine -j$(nproc); fi

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Render requirement
ENV PORT=8080
EXPOSE 8080

CMD ["/start.sh"]