# Flexget
#
# */30 * * * * docker run --rm -v [LOCAL_CONFIG_LOCATION]:/root/.flexget --link transmission:transmission rjszynal/flexget

FROM python:3.7-alpine3.9
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN pip install --upgrade pip \
	&& pip install -I flexget transmissionrpc \
	&& mkdir -p /root/.flexget \
	&& touch /root/.flexget/config.yml

VOLUME ["/root/.flexget"]

CMD ["/usr/local/bin/flexget", "--loglevel", "info", "--cron", "execute"]
