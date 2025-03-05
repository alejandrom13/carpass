# Use an official Dart image with the correct version
FROM dart:3.6.1 AS build

# Set working directory
WORKDIR /app

# Copy the pubspec files and get dependencies
COPY pubspec.yaml pubspec.lock /app/
RUN dart pub get

# Copy the rest of the application files
COPY . /app

# Run build (if necessary)
RUN dart compile exe bin/main.dart -o /app/main

# Use a smaller base image for the runtime
FROM debian:bullseye-slim AS runtime

# Install runtime dependencies
RUN apt-get update && apt-get install -y curl ca-certificates unzip && rm -rf /var/lib/apt/lists/*

# Copy compiled Dart binary from build stage
COPY --from=build /app/main /app/main

# Set working directory
WORKDIR /app

# Expose application port (modify if needed)
EXPOSE 8080

# Run the Dart executable
CMD ["/app/main"]
