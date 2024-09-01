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

FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get install -y \
        ca-certificates \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN buildDeps=' \
        curl \
        gnupg2\
    ' \
    && apt-get update && apt-get install -y ${buildDeps} --no-install-recommends \
    && curl -sSL https://packages.mozilla.org/apt/repo-signing-key.gpg | gpg --dearmor --yes -o /usr/share/keyrings/mozilla.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/mozilla.gpg] https://packages.mozilla.org/apt mozilla main" \
        > /etc/apt/sources.list.d/mozilla.list \
    && apt-get update && apt-get install -y \
        firefox \
    --no-install-recommends \
    && apt-get purge -y --auto-remove ${buildDeps} \
    && rm -rf /var/lib/apt/lists/*

# Add firefox user
RUN useradd -m -G audio,video firefox

# Run as non privileged user
USER firefox

ENTRYPOINT [ "firefox" ]
