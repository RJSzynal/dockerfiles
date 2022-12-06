# Firefox
#
# docker run --rm -d \
#     --cpuset-cpus 0 \
#     --memory 3gb \
#     --shm-size 2g \
#     --device /dev/dri \
#     --device /dev/usb \
#     --device /dev/bus/usb \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -e DISPLAY \
#     -e GDK_SCALE \
#     -e GDK_DPI_SCALE \
#     -v /etc/localtime:/etc/localtime:ro \
#     -v "/etc/hosts:/etc/hosts:ro" \
#     -v ${HOME}/.firefox/cache:/home/firefox/.cache \
#     -v ${HOME}/.firefox/mozilla:/home/firefox/.mozilla \
#     -v ${HOME}/Downloads:/home/firefox/Downloads \
#     --name firefox \
#     rjszynal/firefox

FROM debian:sid-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN apt-get update && apt-get install -y \
        ca-certificates \
        ffmpeg \
        firefox \
        hicolor-icon-theme \
        libcanberra-gtk3-module \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Add firefox user
RUN useradd -m -G audio,video firefox

# Run as non privileged user
USER firefox

ENTRYPOINT [ "firefox" ]
