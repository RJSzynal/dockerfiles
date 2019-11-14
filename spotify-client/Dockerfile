FROM debian:sid-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN apt-get update && apt-get install -y \
		ca-certificates \
		curl \
		gnupg2 \
	--no-install-recommends \
	&& curl -sSL https://download.spotify.com/debian/pubkey.gpg | apt-key add - \
	&& echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list \
	&& apt-get update && apt-get install -y \
		libgl1-mesa-glx \
		libpulse0 \
		spotify-client \
	--no-install-recommends \
	&& apt-get purge --auto-remove -y \
		ca-certificates \
		curl \
		gnupg2 \
	&& rm -rf /var/lib/apt/lists/*

# Add Spotify user
RUN useradd -m -G audio,video spotify

# Run as non privileged user
USER spotify

ENTRYPOINT [ "spotify" ]
