# Run VSCode in a container
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
#     --name vscode \
#     rjszynal/vscode

# Base docker image
FROM debian:sid-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install VSCode dependencies
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

# Install VSCode
RUN buildDeps=' \
		ca-certificates \
		curl \
	' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -L -o /tmp/vscode-amd64.deb https://go.microsoft.com/fwlink/\?LinkID\=760868 \
	&& dpkg -i /tmp/vscode-amd64.deb \
	&& rm -rf /tmp/*.deb \
	&& apt-get purge -y --auto-remove $buildDeps

# Add VSCode user
RUN groupadd -r vscode && useradd -r -g vscode -G audio,video vscode \
	&& mkdir -p /home/vscode && chown -R vscode:vscode /home/vscode

# Run as non privileged user
USER vscode

ENTRYPOINT [ "/usr/share/code/code" ]
