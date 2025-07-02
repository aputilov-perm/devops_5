#!/bin/bash

CERT_DIR="./ssl/certs"
NGINX_CONTAINER="nginx-cont"

echo "Генерируем новый SSL-сертификат..."

mkdir -p "$CERT_DIR"

openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout "$CERT_DIR/nginx.key" \
  -out "$CERT_DIR/nginx.crt" \
  -subj "/C=RU/ST=Moscow/L=Moscow/O=DevOps/CN=localhost"

echo "Перезагружаем Nginx в контейнере..."
docker exec "$NGINX_CONTAINER" nginx -s reload

echo "SSL-сертификат обновлён."
