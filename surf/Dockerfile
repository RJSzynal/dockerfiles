# Surf
#
# docker run -d \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -v $HOME/.surf/config:/home/surf/.config/surf \
#     -e DISPLAY \
#     --name surf \
#     rjszynal/surf

FROM debian:sid-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

RUN apt-get update && apt-get install -y \
        --no-install-recommends \
        ca-certificates \
        suckless-tools \
        x11-utils \
        surf

# Add surf user
ARG username=surf
RUN useradd -m -G audio,video ${username}

# Run as non privileged user
USER ${username}

ENTRYPOINT [ "/usr/bin/surf" ]
