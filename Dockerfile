FROM debian:bullseye-slim

RUN apt-get update && \
  apt-get install -y perl cpanminus wget rsync \
  nodejs npm libssl-dev liblwp-protocol-https-perl nginx && \
  rm -rf /var/lib/apt/lists/*

RUN npm install -g dotenv
RUN dotenv -e .env

WORKDIR /app

COPY modules.txt .

RUN cpanm --notest --save-dists /app/mirror --installdeps App::cpanminus && \
  cpanm --notest --save-dists /app/mirror --installdeps < ~/modules.txt

# Remove default Nginx configuration
RUN rm /etc/nginx/sites-enabled/default

# Create a new Nginx configuration file to serve the mirror directory
RUN echo "server {" \
  "listen 80;" \
  "root /app/mirror;" \
  "index index.html;" \
  "location / {" \
  "try_files \$uri \$uri/ =404;" \
  "}" \
  "}" > /etc/nginx/sites-available/cpan_mirror

# Enable the new Nginx configuration
RUN ln -s /etc/nginx/sites-available/cpan_mirror /etc/nginx/sites-enabled/cpan_mirror

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]