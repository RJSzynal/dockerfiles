# Flexget
#
# */30 * * * * docker run --rm -v [LOCAL_CONFIG_LOCATION]:/home/flexget/.flexget --net container:transmission rjszynal/flexget

FROM python:3-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN pip install --upgrade pip \
	&& pip install -I flexget transmission-rpc

# Hack to get around UnknownTimezoneWarning : https://github.com/Flexget/Flexget/discussions/3070
RUN sed -i 's/(date_string)/(date_string, tzinfos={"CEST": "UTC+2"})/' /usr/local/lib/python3.9/site-packages/flexget/plugins/input/rss.py

# Add Flexget user
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
