# Simple Terminal (st) Monokai Theme
#
# docker run -d \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -v $HOME/.st/config:/home/st/.config/st \
#     -e DISPLAY \
#     --name st \
#     rjszynal/st-monokai

FROM debian:stable-slim as build

RUN apt-get update && apt-get install -y \
        --no-install-recommends \
        ca-certificates \
        libfontconfig1-dev \
        libfreetype6-dev \
        gcc \
        git \
        make \
        libx11-dev \
        libxft-dev

COPY monokai.diff /tmp/

RUN git clone https://git.suckless.org/st /usr/src/st \
    && cd /usr/src/st \
    && git apply /tmp/monokai.diff  \
    && make clean install


FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
    maintainer.email="rjszynal@gmail.com"

RUN apt-get update && apt-get install -y \
        --no-install-recommends \
        # libfontconfig1 \
        # libfreetype6 \
        libx11-6 \
        libxft2 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin/st /usr/bin/st

# Add st user
ARG username=st
RUN useradd -m -G audio,video ${username}

# Run as non privileged user
USER ${username}

ENTRYPOINT [ "/usr/bin/st" ]
