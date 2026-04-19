# OpenClaw on Render (Docker Setup)

This repo provides a Docker setup to build OpenClaw and deploy it on Render.

## ⚠️ Important
Render requires a web service to listen on a port.
This container runs a dummy HTTP server on port 8080 to satisfy that requirement.

## 🚀 Deploy Steps

1. Push this repo to GitHub
2. Go to Render
3. Create a new Web Service
4. Select this repo
5. Choose **Docker environment**
6. Deploy

## 🛠 What This Does
- Builds OpenClaw from source
- Runs a simple HTTP server
- Keeps container alive

## ❌ Limitations
- No GUI support (game won’t display)
- Not suitable for playing OpenClaw

## ✅ Use Cases
- Build verification
- Linux container environment
- Experimentation