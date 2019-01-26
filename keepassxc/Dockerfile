# keepassxc
#
# docker run -d \
#		-v /tmp/.X11-unix:/tmp/.X11-unix \
#		-v /etc/machine-id:/etc/machine-id:ro \
#		-v /usr/share/X11/xkb:/usr/share/X11/xkb/:ro \
#		-v $HOME/.config/keepassxc:/root/.config/keepassxc \
#		-e DISPLAY=unix$DISPLAY \
#		jess/keepassxc
#
FROM alpine:latest as build

ARG version=master

RUN buildDeps=' \
		automake \
		argon2-dev \
		bash \
		cmake \
		curl-dev \
		expat \
		g++ \
		gcc \
		git \
		libgcrypt-dev \
		libmicrohttpd-dev \
		make \
		qt5-qtbase-dev \
		qt5-qttools-dev \
	' \
	set -x \
	&& apk --no-cache add \
		$buildDeps \
	&& git clone --depth 1 --branch ${version} https://github.com/keepassxreboot/keepassxc.git /usr/src/keepassxc \
	&& cd /usr/src/keepassxc \
	&& mkdir build \
	&& cd build \
	&& cmake -DWITH_TESTS=ON -DWITH_XC_AUTOTYPE=ON -DWITH_XC_HTTP=ON .. \
	&& make \
	&& make install \
	&& apk del $buildDeps \
	&& rm -rf /usr/src/keepassxc \
	&& echo "Build complete."

FROM alpine:latest
LABEL maintainer "Christian Koep <christiankoep@gmail.com>"

COPY --from=build /usr/local/bin/keepassxc /usr/bin/keepassxc

RUN	apk --no-cache add \
		argon2-libs \
		libcurl \
		libmicrohttpd \
		libgcrypt \
		mesa-dri-intel \
		mesa-dri-swrast \
		qt5-qtbase \
		qt5-qtbase-x11 \
		qt5-qttools \
		ttf-dejavu

ENV LANG en_GB.UTF-8

# Add keepassxc user
ARG username=keepassxc
RUN addgroup -g 1000 ${username} \
	&& adduser -S -u 1000 -g ${username} ${username}

# Run as non privileged user
USER ${username}

ENTRYPOINT [ "/usr/bin/keepassxc" ]
