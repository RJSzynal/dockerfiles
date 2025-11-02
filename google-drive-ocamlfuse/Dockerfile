# google-drive-ocamlfuse
#
# Usage:
# docker run --rm -d \
#     --name googledrive \
#     --security-opt apparmor:unconfined \
#     --cap-add mknod \
#     --cap-add sys_admin \
#     --device=/dev/fuse \
#     -v ${HOME}/googledrive:/home/gdrive/googledrive:shared \
#     -v ${HOME}/.gdfuse:/home/gdrive/.gdfuse:shared \
#     rjszynal/google-drive-ocamlfuse \
#         -o allow_root /home/gdrive/googledrive

FROM debian:stable-slim
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

# Install google-drive-ocamlfuse
RUN buildDeps=' \
        curl \
        gnupg2 \
        ca-certificates \
    ' \
    && apt-get update && apt-get install -y ${buildDeps} --no-install-recommends \
    && curl -sSL 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xA7AFF39895544C77C124BB46FEAC8456AF83AFEB' | gpg --dearmor --yes -o /usr/share/keyrings/alessandro-strada.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/alessandro-strada.gpg] http://ppa.launchpad.net/alessandro-strada/ppa/ubuntu jammy main" \
        > /etc/apt/sources.list.d/alessandro-strada-ubuntu-ppa-jammy.list \
    && apt-get update && apt-get install -y \
        dirmngr \
        fuse \
        google-drive-ocamlfuse \
    --no-install-recommends \
    && apt-get purge -y --auto-remove ${buildDeps} \
    && rm -rf /var/lib/apt/lists/*

# fusermount: option allow_other only allowed if 'user_allow_other' is set in /etc/fuse.conf
RUN echo "user_allow_other" >> /etc/fuse.conf

# Add gdrive user
RUN useradd -m gdrive

# Run as non privileged user
USER gdrive

ENTRYPOINT [ "/usr/bin/google-drive-ocamlfuse"]
