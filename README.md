## Descriptions

This Fork is to keep this Project going and FMD2 updated. Forked from https://github.com/ElryGH/docker-FMD2

Dockerized FMD2 (Windows with Wine) using KasmVNC, to display GUI on a webpage.

https://github.com/dazedcat19/FMD2


Make sure to configure it using the 'web' ui.

## Features:
* Does not require any display, works headless
* Keeps all of FMD2 features
* Since it's docker, it works on Linux
* Make use of Linuxserver baseimage-kasmvnc:ubuntunoble

## Bulding image
```
git clone https://github.com/dymas-cz/docker-FMD2.git
cd docker-FMD2
docker build . -t fmd2
```

## Docker-compose
```yaml
services:
  fmd2:
    image: ghcr.io/dymas-cz/fmd2:latest
    container_name: fmd2
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
      - UMASK=002
      #- THRESHOLD_MINUTES=3
      #- TRANSFER_FILE_TYPE=.cbz
    ports:
      - 3000:3000
    volumes:
      - ./fmd/userdata:/app/FMD2/userdata
      - ./fmd/data:/app/FMD2/data
      - ./manga:/downloads
    restart: unless-stopped
```

## Kubernetes

https://github.com/TKVH-Apps/fmd2

## License
[MIT](https://choosealicense.com/licenses/mit/)
