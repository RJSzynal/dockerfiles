# GIMP
#
# docker run -d \
#     -v /etc/localtime:/etc/localtime:ro \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -e DISPLAY \
#     -v ${HOME}/Pictures:/home/gimp/Pictures \
#     --name gimp \
#     rjszynal/gimp
#
FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

RUN apt-get update && apt-get install -y \
        gimp \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Add gimp user
RUN useradd -m -G audio,video gimp

# Run as non privileged user
USER gimp

ENTRYPOINT [ "gimp" ]
