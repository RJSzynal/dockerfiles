# Vivaldi
#
# docker run -it \
#	--cpuset-cpus 0 \ # control the cpu
#	--memory 512mb \ # max memory it can use
#	-v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
#	-e DISPLAY=unix$DISPLAY \
#	-v $HOME/Downloads:/home/vivaldi/Downloads \
#	-v $HOME/.config/vivaldi/:/home/vivaldi/.config/vivaldi \ # if you want to save state
#	--security-opt seccomp=$HOME/chrome.json \
#	--device /dev/snd \ # so we have sound
#	-v /dev/shm:/dev/shm \
#	--name vivaldi \
#	rjszynal/vivaldi


FROM debian:sid-slim as build

RUN apt-get update && apt-get install -y \
        binutils \
        ca-certificates \
        wget \
        xz-utils \
        --no-install-recommends

# Support for proprietary codecs
ADD https://launchpadlibrarian.net/401553574/chromium-codecs-ffmpeg-extra_71.0.3578.98-0ubuntu0.16.04.1_amd64.deb /tmp/codecs/codecs.deb
RUN cd /tmp/codecs \
    && ar x codecs.deb data.tar.xz \
    && tar xvJf data.tar.xz \
    && rm -f data.tar.xz codecs.deb \
    && mv usr/lib/chromium-browser/libffmpeg.so /tmp/

FROM debian:sid-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

ENV LANG en-GB.utf-8

COPY tmp/ /tmp/

RUN apt-get update && apt-get install -y \
        ca-certificates \
        gnupg2 \
        --no-install-recommends \
    && apt-key add tmp/repo.key \
    && apt-key add tmp/repo_future.key \
    && echo "deb https://repo.vivaldi.com/stable/deb/ stable main\n" >> /etc/apt/sources.list.d/vivaldi.list \
    && apt-get update && apt-get install -y \
        vivaldi-stable \
        libgl1-mesa-glx \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /tmp/libffmpeg.so /opt/vivaldi/lib/libffmpeg.so

# Add vivaldi user
ARG username=vivaldi
RUN groupadd ${username} \
	&& useradd -g ${username} -G audio,video ${username}

# Run as non privileged user
USER ${username}

ENTRYPOINT [ "/opt/vivaldi/vivaldi" ]
