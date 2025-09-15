This Fork is to keep this Project going and FMD2 updated.

## Descriptions

Dockerized FMD2 (Windows with Wine) using VNC, noVNC and webSocketify to display GUI on a webpage.
Websites protected with Cloudflare do not work with this, FlareSolverr doesnt work with wine.

https://hub.docker.com/r/sillysuki/fmd2

Make sure to configure it using the 'web' ui.

## Features:
* Does not require any display, works headless
* Keeps all of FMD2 features
* Since it's docker, it works on Linux
* Make use of Linuxserver ubuntu image

## Docker
```yaml
services:
  fmd2:
    image: sillysuki/fmd2:latest
    container_name: fmd2
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
      - UMASK=002
      - THRESHOLD_MINUTES=3
      - TRANSFER_FILE_TYPE=.cbz
    ports:
      - 3000:3000
    volumes:
      - ./fmd2:/app/FMD2/userdata
      - ./manga:/downloads
    restart: unless-stopped
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
