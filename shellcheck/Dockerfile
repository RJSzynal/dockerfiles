# shellcheck
#
# Usage:
# docker run --rm -it \
#      -v $(pwd):/usr/src:ro \
#      --workdir /usr/src \
#       rjszynal/shellcheck
#           shellcheck <some_file>

FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

# Install shellcheck
RUN apt-get update && apt-get install -y \
	file \
	shellcheck \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Add shellcheck user
RUN useradd -m shellcheck

# Run as non privileged user
USER shellcheck

ENTRYPOINT [ "/usr/bin/shellcheck" ]
