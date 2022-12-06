# hollywood
#
# Usage:
# docker run --rm -it rjszynal/hollywood

FROM debian:sid-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

# Install hollywood
RUN apt-get update && apt-get install -y \
        apg \
        bmon \
        bsdmainutils \
        ccze \
        cmatrix \
        hollywood \
        htop \
        mlocate \
        moreutils \
        tree \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Add hollywood user
RUN useradd -m -G audio,video hollywood

# Run as non privileged user
USER hollywood

ENTRYPOINT [ "/usr/games/hollywood" ]
