#!/bin/bash
apt install docker.io docker-compose -y

echo "Starting Nginx Proxy Manager installation ..."

if ! command -v docker &> /dev/null
then
    echo "Docker ist ne da BRO installiere Docker mit apt install docker.io -y"
    exit
fi

mkdir nginx-proxy-manager && cd nginx-proxy-manager

cat > docker-compose.yml <<EOF
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
EOF
docker-compose up -d

echo "Nginx Proxy Manager installation ready ..."
echo "Admin UI http://your_ip_address:81"
echo "Default Login:"
echo "Email: admin@example.com"
echo "Password: changeme"