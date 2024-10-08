# Chrome
#
# if [ ! -f ${HOME}/seccomp/chrome.json ]; then
#     mkdir -p ${HOME}/seccomp
#     wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ${HOME}/seccomp/chrome.json
# fi
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
#     -v "/etc/hosts:/etc/hosts:ro"
#     --security-opt seccomp:${HOME}/seccomp/chrome.json
#     -v ${HOME}/.chrome/cache:/home/chrome/.cache
#     -v ${HOME}/.chrome/config:/home/chrome/.config
#     -v ${HOME}/.chrome/pki:/home/chrome/.pki
#     -v ${HOME}/.chrome/local:/home/chrome/.local
#     -v ${HOME}/.chrome/gnome:/home/chrome/.gnome
#     --name chrome \
#     rjszynal/chrome \
#         --user-data-dir="/home/chrome/.config/google-chrome"
#
# You will want the custom seccomp profile:
#     wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/chrome.json

# Base docker image
FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

# Install Chrome
RUN apt-get update && apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        hicolor-icon-theme \
        libcanberra-gtk* \
        libgl1-mesa-dri \
        libgl1-mesa-glx \
        libpulse0 \
        libv4l-0 \
        fonts-symbola \
    --no-install-recommends \
    && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor --yes -o /usr/share/keyrings/google-chrome.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/google-chrome.gpg arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" \
        > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y \
        google-chrome-stable \
    --no-install-recommends \
    && apt-get purge --auto-remove -y curl \
    && rm -rf /var/lib/apt/lists/*

# Download the google-talkplugin
RUN apt-get update && apt-get install -y \
        curl \
        libpango-1.0-0 \
        libgdk-pixbuf2.0-0 \
    --no-install-recommends \
    && curl -sSL "https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb" -o /tmp/google-talkplugin-amd64.deb \
    && dpkg-deb -x /tmp/google-talkplugin-amd64.deb /tmp/google-talkplugin-amd64 \
    && dpkg-deb --control /tmp/google-talkplugin-amd64.deb /tmp/google-talkplugin-amd64/DEBIAN \
    && sed -i "s/libpango1.0-0/libpango-1.0-0/" /tmp/google-talkplugin-amd64/DEBIAN/control \
    && dpkg -b /tmp/google-talkplugin-amd64 /tmp/google-talkplugin-amd64-fixed.deb \
    && dpkg -i /tmp/google-talkplugin-amd64-fixed.deb \
    && rm -rf /tmp/* \
    && apt-get purge -y --auto-remove curl \
    && rm -rf /var/lib/apt/lists/*

# Add chrome user
RUN useradd -m -G audio,video chrome

COPY local.conf /etc/fonts/local.conf

# Run Chrome as non privileged user
USER chrome

# Autorun chrome
ENTRYPOINT [ "google-chrome" ]
CMD [ "--user-data-dir=/data" ]
