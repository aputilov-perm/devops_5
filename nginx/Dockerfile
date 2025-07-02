# Используем базовый образ
FROM nginx:latest

# Копируем кастомный конфиг
COPY nginx.conf /etc/nginx/nginx.conf

# Копируем индексную страницу
COPY index.html /usr/share/nginx/html/index.html

# Открываем порт (не обязателен, так как мы пробрасываем его при запуске)
EXPOSE 80
