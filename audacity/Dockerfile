FROM debian:sid-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN apt-get update && apt-get install -y \
	audacity \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Add Audacity user
RUN groupadd -r audacity && useradd -r -g audacity -G audio,video audacity \
	&& mkdir -p /home/audacity && chown -R audacity:audacity /home/audacity

# Run as non privileged user
USER audacity

ENTRYPOINT [ "audacity" ]
