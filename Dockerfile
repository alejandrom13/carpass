# Use an official Flutter image with Dart 3.6.1
FROM cirrusci/flutter:3.16.9

# Set working directory
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    libstdc++6 \
    fonts-droid-fallback

# Set up environment variables
ENV PATH="/usr/local/flutter/bin:${PATH}"

# Copy pubspec files first to leverage Docker cache
COPY pubspec.yaml pubspec.lock* ./

# Enable null safety and get dependencies
RUN dart --enable-experiment=default-code-style-2024 \
    && flutter pub get

# Copy the rest of the project files
COPY . .

# Generate necessary files (if any)
RUN flutter pub run build_runner build --delete-conflicting-outputs

# Build the app for web
RUN flutter build web

# Use nginx to serve the web app
FROM nginx:alpine

# Copy built web files to nginx html directory
COPY --from=0 /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Default command to run nginx
CMD ["nginx", "-g", "daemon off;"]
