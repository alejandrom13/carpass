# Use the official Flutter image as a base
FROM ghcr.io/cirruslabs/flutter:3.16.3 AS build

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
