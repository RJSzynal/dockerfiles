FROM python:2.7-alpine3.6
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

RUN pip install -I flexget transmissionrpc

RUN mkdir -p /root/.flexget \
	&& touch /root/.flexget/config.yml

VOLUME ["/root/.flexget"]

CMD ["/usr/local/bin/flexget", "--loglevel", "info", "--cron", "execute"]
