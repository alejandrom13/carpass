# Use the latest Flutter image
FROM ghcr.io/cirruslabs/flutter:latest AS build

# Set working directory
WORKDIR /app

# Copy the pubspec files and resolve dependencies
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the app source code
COPY . .

# Build the Flutter web app
RUN flutter build web --release

# Use an Nginx image to serve the built Flutter app
FROM nginx:alpine

# Copy the built Flutter web app to Nginx's web root
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
