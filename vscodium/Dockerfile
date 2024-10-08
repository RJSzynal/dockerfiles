# VSCodium
#
# docker run -d \
#     --net host \
#     -v /etc/localtime:/etc/localtime:ro \
#     -v /etc/passwd:/etc/passwd:ro \
#     -v "${HOME}:${HOME}" \
#     -e DISPLAY \
#     --device /dev/snd \
#     -u $(id -u):$(id -g) \
#     -w $(pwd) \
#     --name vscodium \
#     rjszynal/vscodium

# Base docker image
FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install VSCodium dependencies
RUN apt-get update && apt-get -y install \
		git \
		gnupg \
		libdrm2 \
		libgbm1 \
		libnotify4 \
		libnss3 \
		libsecret-1-0 \
		libx11-xcb1 \
		libxkbfile1 \
		libxss1 \
		libxtst6 \
		libcanberra-gtk3-module \
		openssh-client \
		xdg-utils \
		--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Install VSCodium
RUN buildDeps=' \
        ca-certificates \
        curl \
    ' \
    && set -x \
    && apt-get update && apt-get install -y ${buildDeps} --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && curl -s https://api.github.com/repos/VSCodium/vscodium/releases/latest \
        | grep browser_download_url \
        | grep 'amd64.deb"' \
        | cut -d '"' -f 4 \
        | xargs -n 1 curl -L -o /tmp/vscodium-amd64.deb \
    && dpkg -i /tmp/vscodium-amd64.deb \
    && rm -rf /tmp/*.deb \
    && apt-get purge -y --auto-remove ${buildDeps}

# Add VSCodium user
RUN useradd -m -G audio,video vscodium

# Run as non privileged user
USER vscodium

ENTRYPOINT [ "/usr/share/codium/codium" ]
