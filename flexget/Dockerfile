# Flexget
#
# */30 * * * * docker run --rm -v [LOCAL_CONFIG_LOCATION]:/home/flexget/.flexget --net container:transmission rjszynal/flexget

FROM python:3.11-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

RUN pip install --upgrade pip \
    && apt-get update \
    && apt-get install -y \
        build-essential \
        --no-install-recommends \
    && pip install -I flexget transmission-rpc \
    && apt-get purge --auto-remove -y build-essential \
    && rm -rf /var/lib/apt/lists/*

# Hack to get around UnknownTimezoneWarning : https://github.com/Flexget/Flexget/discussions/3070
RUN sed -i 's/(date_string)/(date_string, tzinfos={"CEST": "UTC+2", "CET": "UTC+1"})/' /usr/local/lib/python3.11/site-packages/flexget/plugins/input/rss.py

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
