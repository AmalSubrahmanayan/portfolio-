#!/bin/bash

# Exit on error
set -e

echo "Starting Flutter Web Build..."

# Check if Flutter is already in path
if ! command -v flutter &> /dev/null
then
    echo "Flutter not found. Installing..."
    if [ ! -d "flutter" ]; then
        git clone https://github.com/flutter/flutter.git -b stable
    fi
    export PATH="$PATH:`pwd`/flutter/bin"
else
    echo "Flutter found in environment."
fi

# Enable web
flutter config --enable-web

# Get dependencies
flutter pub get

# Build web release
flutter build web --release

echo "Build complete!"
