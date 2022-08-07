# syslog-log-viewer
[![Build Status](https://shields.cosanostra-cloud.de/drone/build/alcapone1933/docker-syslog-log-viewer?server=https%3A%2F%2Fdrone.docker-for-life.de)](https://drone.docker-for-life.de/alcapone1933/docker-syslog-log-viewer)
[![Build Status Branch Master](https://shields.cosanostra-cloud.de/drone/build/alcapone1933/docker-syslog-log-viewer/master?label=build%20%5Bbrach%20master%5D&server=https%3A%2F%2Fdrone.docker-for-life.de)](https://drone.docker-for-life.de/alcapone1933/docker-syslog-log-viewer/branches)
[![Docker Pulls](https://shields.cosanostra-cloud.de/docker/pulls/alcapone1933/syslog-log-viewer)](https://hub.docker.com/r/alcapone1933/syslog-log-viewer/tags)
![Docker Image Version (latest semver)](https://shields.cosanostra-cloud.de/docker/v/alcapone1933/syslog-log-viewer?sort=semver)

[![syslog-log-viewer](/img/syslog-log-viewer_2560x1278.png)](https://www.pimpmylog.com/)

Pimp my Log is a web app written in PHP. It displays server logs friendly.

Formerly named PHP Apache Log Viewer, it has been renamed because any kind of logs can be displayed now.
Basically, you will surely display your Apache, NGINX, IIS or PHP logs, but Ruby on Rails, Tomcat, sshd, syslog, CakePHP, ... too !

It's embedded with rsyslog server to make one container for log monitoring
### FORK
https://github.com/greenweb-cloud/syslog-log-viewer
#  Docker HUB
[Docker REPO](https://hub.docker.com/r/alcapone1933/syslog-log-viewer)

# Installation 

# Docker CLI

```bash
docker run -d -it \
--name=syslog-log-viewer \
--restart=always \
-p 8080:80 \
-p 1514:514/udp \
-e TZ=Europe/Berlin \
-e SYSLOG_USERNAME=admin \
-e SYSLOG_PASSWORD=password \
-v syslog_data:/var/log/net/ \
-v syslog_config:/var/www/ \
alcapone1933/syslog-log-viewer:latest

# OR

docker-compose up -d

```

# Docker Compose

```yaml
version: "3.9"
services:
  syslog-log-viewer:
    image: alcapone1933/syslog-log-viewer:latest
    container_name: syslog-log-viewer
    restart: always
    stdin_open: true 
    tty: true        
    ports:
      - 8080:80
      - 1514:514/udp
    environment:
      - TZ=Europe/Berlin
      - SYSLOG_USERNAME=admin
      - SYSLOG_PASSWORD=password
    volumes:
      - data:/var/log/net/
      - config:/var/www/

volumes:
  data:
    name: syslog_data
  config:
    name: syslog_config

```

## Docker Build

```bash
# Docker Build  

git clone https://github.com/alcapone1933/docker-syslog-log-viewer.git syslog-log-viewer
 
cd syslog-log-viewer
 
docker build -t syslog-log-viewer .


# OR

docker build -t syslog-log-viewer https://github.com/alcapone1933/docker-syslog-log-viewer.git

Dockerhub: docker pull alcapone1933/syslog-log-viewer:latest
```


* * *
## Volume params

| Name   | Value  | Example                    |
|--------|--------|----------------------------|
| Volume | Data   | syslog_data:/var/log/net/  |
| Volume | Config | syslog_data:/var/www/      |

* * *

## Env params

| Name                | Value           | Example       |
|---------------------|-----------------|---------------|
| Timezone            | TZ              | Europe/Berlin |
| SYSLOG-WEB-USERNAME | SYSLOG_USERNAME | admin         |
| SYSLOG-WEB-PASSWORD | SYSLOG_PASSWORD | password      |
