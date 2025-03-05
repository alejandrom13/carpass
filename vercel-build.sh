#!/bin/bash

# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:$HOME/flutter/bin"

# Setup Flutter
flutter precache
flutter config --enable-web

# Get dependencies and build
flutter pub get
flutter build web --release