FROM debian:sid-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

RUN apt-get update && apt-get install -y \
		ca-certificates \
		curl \
		gnupg2 \
	--no-install-recommends \
		&& curl -sSL https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/spotify.gpg \
	&& echo "deb [signed-by=/etc/apt/trusted.gpg.d/spotify.gpg] http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list \
	&& apt-get update && apt-get install -y \
		libgl1-mesa-glx \
		libpulse0 \
		libsm6 \
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
