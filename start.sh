#!/bin/bash

echo "Container started"

# Start a simple HTTP server so Render detects a port
cd /app
python3 -m http.server 8080 &

# Keep container alive
tail -f /dev/null