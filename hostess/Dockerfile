# hostess
#
# docker run --rm -d \
#     -v /etc/hosts:/tmp/hosts:rw
#     -e "HOSTESS_PATH=/tmp/hosts"
#     --name hostess \
#     rjszynal/hostess

FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

ARG version=0.5.2
ADD --chmod=755 https://github.com/cbednarski/hostess/releases/download/v${version}/hostess_linux_amd64 /bin/hostess

# Add hostess user
RUN useradd -m -G audio,video hostess

# Run as non privileged user
USER hostess

ENTRYPOINT [ "/bin/hostess" ]
CMD [ "--help" ]
