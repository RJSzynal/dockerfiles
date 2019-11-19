FROM rust:latest as build

WORKDIR /usr/src/

RUN apt-get update && apt-get install -y \
		ca-certificates \
		curl \
		libasound2-dev \
		libssl-dev \
		libpulse-dev \
		libdbus-1-dev \
		unzip \
	--no-install-recommends

RUN export version=$(curl -s https://api.github.com/repos/Spotifyd/spotifyd/releases/latest | grep "tag_name" | cut -d '"' -f 4 | sed 's/^v//') \
	&& curl -Lo /tmp/source.zip \
		https://github.com/Spotifyd/spotifyd/archive/v${version}.zip \
	&& unzip /tmp/source.zip \
	&& cd spotifyd-${version} \
	&& cargo build --release --features pulseaudio_backend \
	&& mv target/release/spotifyd /usr/bin/


FROM debian:sid-slim
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

# Install Spotifyd dependencies
RUN apt-get update && apt-get -y install \
		libpulse0 \
		libasound2 \
		--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/bin/spotifyd /usr/bin/

# Add Spotify user
RUN useradd -mG audio spotify

# Run as non privileged user
USER spotify

ENTRYPOINT [ "/usr/bin/spotifyd", "--no-daemon" ]
