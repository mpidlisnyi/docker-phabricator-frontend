Container for [Phabricator](https://phacility.com/phabricator/) frontend (nginx)

Examples of docker-compose.yml
```
version: '2'
services:
  nginx:
    image: <put here name of this image>
    environment:
      - FASTCGI_PASS=php:9000
    ports:
     - "80:80"
     - "443:443"
    links:
     - php
```

```
version: '2'
services:
  nginx:
    image: <put here name of this image>
    environment:
     - SSL_CERTIFICATE=/ssl/my.crt
     - SSL_CERTIFICATE_KEY=/ssl/my.key
     - FASTCGI_PASS=unix:/var/run/phabricator/phabricator.sock
     - SERVER_NAME=phabricator.mycompany.com,www.phabricator.mycompany.com
    volumes:
     - /path/to/your/certs:/ssl
     - /var/run/phabricator:/var/run/phabricator
    ports:
     - "443:443"
    links:
     - php
```

where php is name of your container with phabricator php fpm
