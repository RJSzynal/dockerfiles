# Flexget
#
# */30 * * * * docker run --rm -v [LOCAL_CONFIG_LOCATION]:/home/flexget/.flexget --net container:transmission rjszynal/flexget

FROM python:3.7-alpine3.9
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN pip install --upgrade pip \
	&& pip install -I flexget transmissionrpc

RUN addgroup -g 1000 -S flexget \
	&& adduser -SDG flexget -u 1000 -h /home/flexget flexget \
	&& mkdir -p /home/flexget/.flexget \
	&& chown flexget:flexget /home/flexget/.flexget

ENV HOME /home/flexget
WORKDIR /home/flexget
USER flexget

VOLUME ["/home/flexget"]

ENTRYPOINT ["/usr/local/bin/flexget"]

CMD ["--loglevel", "info", "--cron", "execute"]
