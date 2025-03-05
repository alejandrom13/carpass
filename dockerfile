# Usa una imagen oficial de Flutter
FROM cirrusci/flutter:stable

# Establece el directorio de trabajo
WORKDIR /app

# Copia el código fuente de tu proyecto
COPY . .

# Instala las dependencias de Flutter
RUN flutter pub get

# Construye la aplicación Flutter Web
RUN flutter build web --release

# Configura el puerto que Vercel usará
EXPOSE 5000

# Configura el comando para iniciar el servidor web
CMD ["python3", "-m", "http.server", "5000"]
