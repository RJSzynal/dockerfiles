# Folding@Home
#
# docker run --rm -d \
# 	--gpus=all \
#	-v /root/.fah:/fah \
# 	--name folding \
# 	rjszynal/foldingathome \
#		--user=<YOUR_USERNAME> \
#		--team=<YOUR_TEAM> \
#		--priority=idle \
#		--power=full

FROM debian:sid-slim as build

WORKDIR "/"

RUN apt-get update 
RUN apt-get install -y --no-install-recommends \
		bzip2 \
		ca-certificates \
		ocl-icd-opencl-dev \
		tar \
		wget
# point at lib mapped in by container runtime
RUN echo "libnvidia-opencl.so.1" > /nvidia.icd
#Get the application binaries
ARG fah_version
RUN wget https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v${fah_version%.*}/fahclient_${fah_version}-64bit-release.tar.bz2
RUN tar -jxvf /fahclient_${fah_version}-64bit-release.tar.bz2
RUN mv fahclient_${fah_version}-64bit-release/FAHC* /


# CUDA 9.2 is chosen to be compatable with all drivers v396+
FROM nvidia/cuda:9.2-base-ubuntu18.04
LABEL maintainer "Robert Szynal <rjszynal@gmail.com>"

# RUN apt-get update && apt-get install -y \
# 		clinfo \
# 		ocl-icd-opencl-dev \
# 	--no-install-recommends \
# 	&& rm -rf /var/lib/apt/lists/*

COPY --from=build /FAHC* /usr/bin/
COPY --from=build /nvidia.icd /etc/OpenCL/vendors/
COPY --from=build /usr/lib/x86_64-linux-gnu/libOpenCL.so /usr/lib/x86_64-linux-gnu/

# Add Folding user
RUN useradd -m folding

# Run as non privileged user
USER folding

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

WORKDIR "/fah"
VOLUME ["/fah"]
EXPOSE 7396 36330

ENTRYPOINT ["/usr/bin/FAHClient", "--chdir", "/fah", "--web-allow=0/0:7396", "--allow=0/0:7396"]
CMD ["--user=Anonymous", "--team=0", "--priority=idle", "--power=full"]
