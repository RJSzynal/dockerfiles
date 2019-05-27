# Flexget
#
# */30 * * * * docker run --rm -v [LOCAL_CONFIG_LOCATION]:/root/.flexget --link transmission:transmission rjszynal/flexget

FROM python:2.7-alpine3.6
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN pip install -I flexget transmissionrpc

RUN mkdir -p /root/.flexget \
	&& touch /root/.flexget/config.yml

VOLUME ["/root/.flexget"]

CMD ["/usr/local/bin/flexget", "--loglevel", "info", "--cron", "execute"]
