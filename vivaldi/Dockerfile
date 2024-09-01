# Vivaldi
#
# docker run -it \
#     --cpuset-cpus 0 \ # control the cpu
#     --memory 512mb \ # max memory it can use
#     -v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
#     -e DISPLAY=unix$DISPLAY \
#     -v $HOME/Downloads:/home/vivaldi/Downloads \
#     -v $HOME/.config/vivaldi/:/home/vivaldi/.config/vivaldi \ # if you want to save state
#     --security-opt seccomp=$HOME/chrome.json \
#     --device /dev/snd \ # so we have sound
#     -v /dev/shm:/dev/shm \
#     --name vivaldi \
#     rjszynal/vivaldi

FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

ENV LANG en-GB.utf-8

RUN apt-get update && apt-get install -y \
        ca-certificates \
        curl \
        gnupg2 \
        xz-utils \
        --no-install-recommends \
    && curl -sSL https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor --yes -o /usr/share/keyrings/vivaldi.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/vivaldi.gpg] https://repo.vivaldi.com/stable/deb/ stable main" \
        > /etc/apt/sources.list.d/vivaldi.list \
    && apt-get update && apt-get install -y \
        vivaldi-stable \
        libgl1-mesa-glx \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN /opt/vivaldi/update-ffmpeg

# Add vivaldi user
ARG username=vivaldi
RUN groupadd ${username} \
    && useradd -m -g ${username} -G audio,video ${username}

# Run as non privileged user
USER ${username}

ENTRYPOINT [ "/opt/vivaldi/vivaldi" ]
