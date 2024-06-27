FROM debian:stable-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN apt-get update && apt-get install -y \
    audacity \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Add Audacity user
RUN useradd -m -G audio,video audacity

# Run as non privileged user
USER audacity

ENTRYPOINT [ "audacity" ]
