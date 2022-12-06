# Run gitsome command line tool:
# https://github.com/donnemartin/gitsome
#
# Usage:
# docker run --rm -it \
#     -v ${HOME}/.gitsome/config:/home/gitsome/.gitsomeconfig \
#     -v ${HOME}/.gitsome/configurl:/home/gitsome/.gitsomeconfigurl \
#     rjszynal/gitsome

FROM python:3.7-alpine3.9
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN pip3 install gitsome

RUN addgroup -g 1000 -S gitsome \
    && adduser -SDG gitsome -u 1000 -h /home/gitsome gitsome \
    && mkdir -p /home/gitsome/.gitsome \
    && chown gitsome:gitsome /home/gitsome/.gitsome

ENV HOME /home/gitsome
WORKDIR /home/gitsome
USER gitsome

ENTRYPOINT ["gitsome"]
