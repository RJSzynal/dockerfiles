# Folding@Home
#
# docker run --rm -d \
#     --gpus=all \
#     -v /root/.fah:/fah \
#     --name folding \
#      rjszynal/foldingathome \
#        --user=<YOUR_USERNAME> \
#        --team=<YOUR_TEAM> \
#        --priority=idle \
#        --power=full

FROM debian:stable-slim as build

WORKDIR "/"

RUN apt-get update 
RUN apt-get install -y --no-install-recommends \
        ocl-icd-opencl-dev
# point at lib mapped in by container runtime
RUN echo "libnvidia-opencl.so.1" > /nvidia.icd


# CUDA 9.2 is chosen to be compatable with all drivers v396+
FROM nvidia/cuda:9.2-base-ubuntu18.04
LABEL maintainer.name="Robert Szynal" \
      maintainer.email="rjszynal@gmail.com"

# Add Folding user
RUN useradd -m fah-client

# Install Folding at Home Client
RUN buildDeps=' \
        ca-certificates \
        curl \
        jq \
    ' \
    && set -x \
    && apt-get update && apt-get install -y ${buildDeps} --no-install-recommends \
    && fah_url=$(curl -s https://download.foldingathome.org/ | jq -r '.[] | select(.platform=="lin") | .groups[] | select(.oses[]=="Debian") | .files[] | select(.filename | contains("amd64")) | .url') \
    && curl -L -o /tmp/${fah_url##*/} ${fah_url} \
    && dpkg -i /tmp/${fah_url##*/} \
    && rm -f /tmp/${fah_url##*/} \
    && apt-get purge -y --auto-remove ${buildDeps} \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /nvidia.icd /etc/OpenCL/vendors/
COPY --from=build /usr/lib/x86_64-linux-gnu/libOpenCL.so /usr/lib/x86_64-linux-gnu/

# Run as non privileged user
USER fah-client

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

WORKDIR "/fah"
VOLUME ["/fah"]
EXPOSE 7396 36330

ENTRYPOINT ["/usr/bin/FAHClient", "--chdir", "/fah", "--web-allow=0/0:7396", "--allow=0/0:7396"]
CMD ["--user=Anonymous", "--team=0", "--priority=idle", "--power=full"]
