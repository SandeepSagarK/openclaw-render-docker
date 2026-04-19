#!/bin/bash

echo "Starting virtual display..."

# Start X virtual framebuffer
Xvfb :1 -screen 0 1024x768x16 &

sleep 2

# Start window manager
fluxbox &

# Start VNC server
x11vnc -display :1 -nopw -forever -shared &

# Start noVNC (browser access)
websockify --web=/usr/share/novnc/ 8080 localhost:5900 &

echo "Starting OpenClaw..."

cd /app/openclaw

# Try to launch game
./openclaw 2>/dev/null || ./engine/openclaw 2>/dev/null || echo "OpenClaw binary not found"

# Keep container alive
tail -f /dev/null