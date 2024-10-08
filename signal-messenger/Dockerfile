FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

ARG version=1.21.1

RUN apt-get update && apt-get install -y \
        curl \
        ca-certificates \
        gnupg2 \
        --no-install-recommends \
    && curl -s https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor --yes -o /usr/share/keyrings/signal.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/signal.gpg arch=amd64] https://updates.signal.org/desktop/apt xenial main" \
        > /etc/apt/sources.list.d/signal.list \
    && apt-get update && apt-get install -y \
        libgtk-3-0 \
        libx11-xcb1 \
        signal-desktop=${version} \
    --no-install-recommends \
    && apt-get remove -y \
        curl \
        gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# Add signal user
RUN groupadd signal \
    && useradd -g signal -G audio,video signal \
    && mkdir -p /home/signal/Downloads \
    && chown -R signal:signal /home/signal

# Run as non privileged user
USER signal

ENTRYPOINT [ "signal-desktop" ]
