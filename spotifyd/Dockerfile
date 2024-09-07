FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

ENV DEBIAN_FRONTEND="noninteractive"

# Install Spotifyd dependencies
RUN apt-get update && apt-get -y install \
        libpulse0 \
        libasound2 \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Spotifyd
RUN buildDeps=' \
        ca-certificates \
        curl \
    ' \
    && set -x \
    && apt-get update && apt-get install -y ${buildDeps} --no-install-recommends \
    && curl -s https://api.github.com/repos/Spotifyd/spotifyd/releases/latest \
        | grep browser_download_url \
        | grep 'linux-slim.tar.gz"' \
        | cut -d '"' -f 4 \
        | xargs -n 1 curl -L -o /tmp/spotifyd-linux-slim.tar.gz \
    && tar -xvf /tmp/spotifyd-linux-slim.tar.gz -C /usr/bin \
    && rm -rf /tmp/*.tar.gz \
    && apt-get purge -y --auto-remove ${buildDeps} \
    && rm -rf /var/lib/apt/lists/*

# Add Spotify user
RUN useradd -mG audio spotify

# Run as non privileged user
USER spotify

ENTRYPOINT [ "/usr/bin/spotifyd", "--no-daemon" ]
