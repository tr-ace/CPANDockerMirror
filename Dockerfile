# Download a debian image
FROM debian:bullseye-slim

# Set work directory
WORKDIR /app

# Copy modules.txt from host machine
COPY modules.txt .

# Create the mirror folder for the modules to be stored in
RUN mkdir mirror

# Download all necessary packages
RUN apt-get update && \
  apt-get install -y perl cpanminus wget rsync \ 
  libssl-dev liblwp-protocol-https-perl nginx nano

# Remove unnecessary files
RUN  rm -rf /var/lib/apt/lists/* && \
  rm /etc/nginx/sites-enabled/default 

# Initialize CPANM
RUN cpan App::cpanminus

# Install App::cpanminus and modules from modulex.txt
RUN cpanm --notest --save-dists /app/mirror --installdeps App::cpanminus && \
  cpanm --notest --save-dists /app/mirror --installdeps < modules.txt

# Copy NGINX config file to container
COPY nginx.conf /etc/nginx/conf.d/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]