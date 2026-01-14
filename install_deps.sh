#!/bin/bash
# Install script for specRL system dependencies

set -e

echo "=================================="
echo "specRL Dependency Installer"
echo "=================================="
echo ""

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    echo "Detected: Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    echo "Detected: macOS"
else
    echo "Unsupported OS: $OSTYPE"
    echo "Please install dependencies manually."
    exit 1
fi

echo ""

# Install dependencies based on OS
if [ "$OS" == "linux" ]; then
    echo "Installing dependencies via apt..."
    echo "This will run: sudo apt update && sudo apt install -y ..."
    echo ""
    
    sudo apt update
    sudo apt install -y \
        libprotobuf-dev \
        protobuf-compiler \
        libprotoc-dev \
        libgrpc-dev \
        libgrpc++-dev \
        protobuf-compiler-grpc \
        libxxhash-dev \
        libboost-all-dev \
        cmake \
        pkg-config \
        build-essential
    
    echo ""
    echo "✓ Dependencies installed successfully!"
    
elif [ "$OS" == "macos" ]; then
    echo "Installing dependencies via Homebrew..."
    
    # Check if brew is installed
    if ! command -v brew &> /dev/null; then
        echo "Error: Homebrew is not installed."
        echo "Please install Homebrew first: https://brew.sh"
        exit 1
    fi
    
    brew install \
        protobuf \
        grpc \
        xxhash \
        boost \
        cmake \
        pkg-config
    
    echo ""
    echo "✓ Dependencies installed successfully!"
fi

echo ""
echo "You can now install specRL:"
echo "  pip install ."
echo ""
echo "Or install from Git:"
echo "  pip install git+https://github.com/sunyingbo83-hub/specRL_fix.git"
echo ""
