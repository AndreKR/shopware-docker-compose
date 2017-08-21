# Shopware docker-compose.yml

## docker-compose.yml

```yaml
version: '3.2'

services:
 db:
  image: mysql:latest
  environment:
   - MYSQL_ROOT_PASSWORD=root
   - MYSQL_DATABASE=shopware
  tmpfs:
   - /var/log
  volumes:
   - ./data/db:/var/lib/mysql

 shopware:
  build:
   context: https://github.com/AndreKR/shopware-docker-compose.git#master:build/
  links:
   - db
  ports:
   - "127.0.0.1:8080:80"
  volumes:
   - type: volume
     source: ./data/shopware
     target: /var/www/localhost/htdocs
```

## Usage

Copy the code above to a new directory and name it `docker-compose.yml`, edit as necessary, run `docker-compose up -d`
