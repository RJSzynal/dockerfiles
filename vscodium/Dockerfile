# Run VSCodium in a container
#
# docker run -d \
#     --net host \
#     -v /etc/localtime:/etc/localtime:ro \
#     -v /etc/passwd:/etc/passwd:ro \
#     -v "${HOME}:${HOME}" \
#     -e "DISPLAY=unix${DISPLAY}" \
#     --device /dev/dri \
#     -u $(id -u):$(id -g) \
#     -w $(pwd) \
#     --name vscodium \
#     jnvinet/vscodium

# Base docker image
FROM debian:sid-slim
LABEL maintainer "Julien Vinet <contact@julienvinet.dev>"

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install VSCodium dependencies
RUN apt-get update && apt-get -y install \
		git \
		gnupg \
		libnotify4 \
		libnss3 \
		libsecret-1-0 \
		libx11-xcb1 \
		libxkbfile1 \
		libxss1 \
		libxtst6 \
		libcanberra-gtk3-module \
		openssh-client \
		--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Install VSCodium
RUN buildDeps=' \
		ca-certificates \
		curl \
	' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -s https://api.github.com/repos/VSCodium/vscodium/releases/latest \
		| grep browser_download_url \
		| grep 'amd64.deb"' \
		| cut -d '"' -f 4 \
		| xargs -n 1 curl -L -o /tmp/vscodium-amd64.deb \
	&& dpkg -i /tmp/vscodium-amd64.deb \
	&& rm -rf /tmp/*.deb \
	&& apt-get purge -y --auto-remove $buildDeps

# Add VSCodium user
RUN groupadd -r vscodium && useradd -r -g vscodium -G audio,video vscodium \
	&& mkdir -p /home/vscodium && chown -R vscodium:vscodium /home/vscodium

# Run as non privileged user
USER vscodium

ENTRYPOINT [ "/usr/share/vscodium/vscodium" ]
