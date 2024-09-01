# htop
#
# docker run --rm -it \
#     --pid host \
#     rjszynal/htop

FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

# Install htop
RUN apt-get update && apt-get install -y \
        htop \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Add htop user
RUN useradd -m -G audio,video htop

# Run as non privileged user
USER htop

ENTRYPOINT [ "htop" ]
