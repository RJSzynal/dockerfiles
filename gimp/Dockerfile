# Run gimp in a contianer
#
# docker run -d \
#	-v /etc/localtime:/etc/localtime:ro \
#	-v /tmp/.X11-unix:/tmp/.X11-unix \
#	-e DISPLAY \
#	-v ${HOME}/Pictures:/home/gimp/Pictures \
#	--name gimp \
#	rjszynal/gimp
#
FROM debian:sid-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN apt-get update && apt-get install -y \
		gimp \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Add gimp user
RUN groupadd -r gimp && useradd -r -g gimp -G audio,video gimp \
	&& mkdir -p /home/gimp/Downloads && chown -R gimp:gimp /home/gimp

# Run as non privileged user
USER gimp

ENTRYPOINT [ "gimp" ]
