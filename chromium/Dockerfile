# Chromium
#
# if [ ! -f ${HOME}/seccomp/chrome.json ]; then
# 	mkdir -p ${HOME}/seccomp
# 	wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ${HOME}/seccomp/chrome.json
# fi
# docker run --rm -d \
# 	--cpuset-cpus 0 \
# 	--memory 3gb \
# 	--shm-size 2g \
# 	--device /dev/dri \
# 	--device /dev/usb \
# 	--device /dev/bus/usb \
# 	-v /tmp/.X11-unix:/tmp/.X11-unix \
# 	-e DISPLAY \
# 	-e GDK_SCALE \
# 	-e GDK_DPI_SCALE \
# 	-v /etc/localtime:/etc/localtime:ro \
# 	-v "/etc/hosts:/etc/hosts:ro"
# 	--security-opt seccomp:${HOME}/seccomp/chrome.json
# 	-v ${HOME}/.chromium/cache:/home/chromium/.cache
# 	-v ${HOME}/.chromium/config:/home/chromium/.config
# 	-v ${HOME}/.chromium/pki:/home/chromium/.pki
# 	-v ${HOME}/.chromium/local:/home/chromium/.local
# 	-v ${HOME}/.chromium/gnome:/home/chromium/.gnome
# 	--name chromium \
# 	rjszynal/chromium \
# 		--user-data-dir="/home/chromium/.config/chromium"
#
# You will want the custom seccomp profile:
# 	wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/chrome.json

# Base docker image
FROM debian:sid-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

# Install Chromium
RUN apt-get update && apt-get install -y \
		chromium \
		chromium-l10n \
		fonts-liberation \
		fonts-roboto \
		hicolor-icon-theme \
		libcanberra-gtk-module \
		libexif-dev \
		libgl1-mesa-dri \
		libgl1-mesa-glx \
		libv4l-0 \
		fonts-symbola \
		--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /etc/chromium.d/ \
	&& /bin/echo -e 'export GOOGLE_API_KEY="AIzaSyCkfPOPZXDKNn8hhgu3JrA62wIgC93d44k"\nexport GOOGLE_DEFAULT_CLIENT_ID="811574891467.apps.googleusercontent.com"\nexport GOOGLE_DEFAULT_CLIENT_SECRET="kdloedMFGdGla2P1zacGjAQh"' > /etc/chromium.d/googleapikeys

# Download the google-talkplugin
RUN apt-get update && apt-get install -y \
		ca-certificates \
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

# Add chromium user
RUN useradd -m -G audio,video chromium

# Run as non privileged user
USER chromium

ENTRYPOINT [ "/usr/bin/chromium" ]
CMD [ "--user-data-dir=/data" ]
