#!/bin/bash
set -e

# Activate venv if it exists, otherwise assume uv runs it
# But since we are using uv run, we can just use that.

echo "Building backend with PyInstaller..."

# PyInstaller command
# --onefile: Create a single executable
# --name: extractro_backend
# --clean: Clean cache
# --hidden-import: uvicorn (sometimes needed)
# --collect-all: easyocr (to grab model files if we wanted, but easyocr is tricky. Let's try basic first)

# Note: EasyOCR might need data files. 
# We will use --collect-all easyocr just in case to get necessary libs.

uv run pyinstaller run.py \
    --name extractro_backend \
    --onefile \
    --clean \
    --collect-all easyocr \
    --hidden-import="uvicorn.logging" \
    --hidden-import="uvicorn.loops" \
    --hidden-import="uvicorn.loops.auto" \
    --hidden-import="uvicorn.protocols" \
    --hidden-import="uvicorn.protocols.http" \
    --hidden-import="uvicorn.protocols.http.auto" \
    --hidden-import="uvicorn.lifespan" \
    --hidden-import="uvicorn.lifespan.on"

echo "Build complete. Executable is in dist/extractro_backend"
