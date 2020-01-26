# Simple Terminal (st)
#
# docker run -d \
#		-v /tmp/.X11-unix:/tmp/.X11-unix \
#		-v $HOME/.config/st:/root/.config/st \
#		-e DISPLAY \
#		--name st \
#		rjszynal/st

FROM debian:sid-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

RUN apt-get update && apt-get install -y \
		--no-install-recommends \
		stterm

# Add st user
ARG username=st
RUN groupadd ${username} \
	&& useradd -g ${username} -G audio,video ${username}

# Run as non privileged user
USER ${username}

ENTRYPOINT [ "/usr/bin/st" ]
