#!/bin/bash

# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:$HOME/flutter/bin"

# Verify Flutter installation
flutter --version

# Enable web support
flutter config --enable-web

# Get dependencies
flutter pub get

# Build web version
flutter build web --release