FROM nginx:alpine

# Remove default nginx static content
RUN rm -rf /usr/share/nginx/html/*

# Copy site files
COPY index.html /usr/share/nginx/html/
COPY favicon.svg /usr/share/nginx/html/
COPY photo.jpg /usr/share/nginx/html/
COPY photo.webp /usr/share/nginx/html/
COPY castlerigg.jpg /usr/share/nginx/html/
COPY castlerigg.webp /usr/share/nginx/html/

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# nginx runs in foreground
CMD ["nginx", "-g", "daemon off;"]
