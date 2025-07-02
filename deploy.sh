#!/bin/bash

# Путь к каталогу проекта
PROJECT_DIR=$(cd "$(dirname "$0")" && pwd)

# Имя образа и контейнера
IMAGE_NAME="nginx-server"
CONTAINER_NAME="nginx-cont"

# Остановить и удалить старый контейнер (если есть)
if [ "$(docker ps -a -f "name=$CONTAINER_NAME" --format "{{.Status}}")" ]; then
  echo "Останавливаем старый контейнер..."
  docker stop "$CONTAINER_NAME"
  docker rm "$CONTAINER_NAME"
fi

# Сборка образа
echo "Собираем образ $IMAGE_NAME..."
docker build -t "$IMAGE_NAME" "$PROJECT_DIR/nginx"

# Запуск контейнера
echo "Запускаем контейнер $CONTAINER_NAME..."
docker run -d \
  --name "$CONTAINER_NAME" \
  -p 54321:80 \
  -p 54433:443 \
  -v "$PROJECT_DIR/ssl/certs:/etc/nginx/ssl" \
  --restart unless-stopped \
  "$IMAGE_NAME"

echo "Контейнер запущен. Откройте http://localhost:54321"
