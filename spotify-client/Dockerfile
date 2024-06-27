FROM debian:stable-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

ENV DEBIAN_FRONTEND="noninteractive"

RUN buildDeps=' \
        ca-certificates \
        curl \
        gnupg2\
    ' \
    && apt-get update && apt-get install -y ${buildDeps} --no-install-recommends \
        && curl -sSL https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg \
    && echo "deb [signed-by=/etc/apt/trusted.gpg.d/spotify.gpg] http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list \
    && apt-get update && apt-get install -y \
        libgl1-mesa-glx \
        libpulse0 \
        libsm6 \
        spotify-client \
    --no-install-recommends \
    && apt-get purge -y --auto-remove ${buildDeps} \
    && rm -rf /var/lib/apt/lists/*

# Add Spotify user
RUN useradd -m -G audio,video spotify

# Run as non privileged user
USER spotify

ENTRYPOINT [ "spotify" ]
