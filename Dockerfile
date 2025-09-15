FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

ARG FMD2_VERSION="2.0.34.5"

LABEL \
  maintainer="mail@suki.buzz"

ENV \
  WINEDLLOVERRIDES="mscoree,mshtml=" \
  WINEDEBUG="-all"\
  HOME=/config

# Install FMD2
RUN \
  apt update && \
  apt install -y dpkg && \
  dpkg --add-architecture i386 && \
  apt install -y wine64 wget p7zip-full curl git python3-pyxdg inotify-tools rsync openbox &&\
  curl -s https://api.github.com/repos/dazedcat19/FMD2/releases/tags/${FMD2_VERSION} | grep "browser_download_url.*download.*fmd.*x86_64.*.7z" | cut -d : -f 2,3 | tr -d '"' | wget -qi - -O FMD2.7z && \
  7z x FMD2.7z -o/app/FMD2 && \
  rm FMD2.7z && \
  apt autoremove -y p7zip-full wget curl --purge && \
  mkdir /downloads && \
  mkdir -p /app/FMD2/userdata && \
  mkdir -p /app/FMD2/downloads \

# Copy my settings preset
COPY settings.json root /
ADD root /

#Install Cloudflare Workaround for Multiple Sites
RUN apt-get update && \
    apt-get install -y python3 tar wget && \
    touch /app/FMD2/lua/use_webdriver && \
    pip install requests && \
    curl -s https://api.github.com/repos/FlareSolverr/FlareSolverr/releases/latest \
      | grep "browser_download_url.*flaresolverr_linux_x64.tar.gz" \
      | cut -d : -f 2,3 | tr -d '"' \
      | wget -qi - -O /tmp/flaresolverr.tar.gz && \
    mkdir -p /app/FMD2/lua/websitebypass/flaresolverr && \
    tar -xzf /tmp/flaresolverr.tar.gz -C /app/FMD2/lua/websitebypass/flaresolverr --strip-components=1 && \
    rm /tmp/flaresolverr.tar.gz
  
WORKDIR /app/FMD2/lua/websitebypass/flaresolverr
CMD ["./flaresolverr"]

VOLUME /config
EXPOSE 3000
