# Flexget
#
# */30 * * * * docker run --rm -v [LOCAL_CONFIG_LOCATION]:/home/flexget/.flexget --net container:transmission rjszynal/flexget

FROM python:3-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN pip install --upgrade pip \
	&& pip install -I flexget transmissionrpc

# Add Spotify user
RUN groupadd -g 1000 flexget \
	&& useradd -mg flexget -u 1000 flexget \
	&& mkdir -p /home/flexget/.flexget \
	&& chown flexget:flexget /home/flexget/.flexget

# Run as non privileged user
USER flexget

WORKDIR /home/flexget

VOLUME ["/home/flexget"]

ENTRYPOINT ["/usr/local/bin/flexget"]

CMD ["--loglevel", "info", "--cron", "execute"]
