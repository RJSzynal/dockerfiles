FROM debian:sid-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN apt-get update && apt-get install -y \
		ca-certificates \
		groff \
		less \
		python3-setuptools \
		python3-pip \
	--no-install-recommends \
	&& pip3 install awscli \
	&& rm -rf /var/lib/apt/lists/*

# Add Audacity user
RUN groupadd -r aws && useradd -r -g aws -G audio,video aws \
	&& mkdir -p /home/aws && chown -R aws:aws /home/aws

# Run as non privileged user
USER aws

ENTRYPOINT [ "aws" ]
