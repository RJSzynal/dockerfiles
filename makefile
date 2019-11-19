docker_repo_prefix  := rjszynal
project_dockerfiles := $(wildcard */Dockerfile)
projects            := $(project_dockerfiles:%/Dockerfile=%)

.PHONY: all alpine debian audacity awscli azure-cli chrome chrome-beta chromium firefox flexget gcloud gimp gitsome hollywood htop keepass2 keepassxc signal-messenger signal-messenger-beta spotifyd spotify-client vivaldi vscode vscodium

all: ${projects}

alpine: azure-cli flexget gcloud gitsome keepassxc

debian: audacity awscli chrome chrome-beta chromium firefox gimp hollywood htop keepass2 signal-messenger signal-messenger-beta spotifyd spotify-client vivaldi vscode vscodium

audacity:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

awscli:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

azure-cli:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

chrome:
	@echo "==Building ${@}=="
	docker build --no-cache -t ${docker_repo_prefix}/${@}:latest ${@}
	version=$$(docker run --rm ${docker_repo_prefix}/${@}:latest --version | cut -d ' ' -f 3); \
	part_version=$${version%.*}; \
	docker build -t ${docker_repo_prefix}/${@}:$${version} -t ${docker_repo_prefix}/${@}:$${part_version} -t ${docker_repo_prefix}/${@}:$${part_version%.*} -t ${docker_repo_prefix}/${@}:$${part_version%%.*} -t ${docker_repo_prefix}/${@}:latest ${@}; \
	docker push ${docker_repo_prefix}/${@}:$${version}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version%.*}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version%%.*}; \
	docker push ${docker_repo_prefix}/${@}:latest

chrome-beta:
	@echo "==Building ${@}=="
	docker build --no-cache -t ${docker_repo_prefix}/${@}:latest ${@}
	version=$$(docker run --rm ${docker_repo_prefix}/${@}:latest --version | cut -d ' ' -f 3); \
	part_version=$${version%.*}; \
	docker build -t ${docker_repo_prefix}/${@}:$${version} -t ${docker_repo_prefix}/${@}:$${part_version} -t ${docker_repo_prefix}/${@}:$${part_version%.*} -t ${docker_repo_prefix}/${@}:$${part_version%%.*} -t ${docker_repo_prefix}/${@}:latest ${@}; \
	docker push ${docker_repo_prefix}/${@}:$${version}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version%.*}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version%%.*}; \
	docker push ${docker_repo_prefix}/${@}:latest

chromium:
	@echo "==Building ${@}=="
	docker build --no-cache -t ${docker_repo_prefix}/${@}:latest ${@}
	version=$$(docker run --rm ${docker_repo_prefix}/${@}:latest --version | cut -d ' ' -f 3); \
	part_version=$${version%.*}; \
	docker build -t ${docker_repo_prefix}/${@}:$${version} -t ${docker_repo_prefix}/${@}:$${part_version} -t ${docker_repo_prefix}/${@}:$${part_version%.*} -t ${docker_repo_prefix}/${@}:$${part_version%%.*} -t ${docker_repo_prefix}/${@}:latest ${@}; \
	docker push ${docker_repo_prefix}/${@}:$${version}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version%.*}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version%%.*}; \
	docker push ${docker_repo_prefix}/${@}:latest

firefox:
	@echo "==Building ${@}=="
	docker build --no-cache -t ${docker_repo_prefix}/${@}:latest ${@}
	version=$$(docker run --rm ${docker_repo_prefix}/${@}:latest --version | cut -d ' ' -f 3); \
	docker build -t ${docker_repo_prefix}/${@}:$${version} -t ${docker_repo_prefix}/${@}:$${version%.*} -t ${docker_repo_prefix}/${@}:$${version%%.*} -t ${docker_repo_prefix}/${@}:latest ${@}; \
	docker push ${docker_repo_prefix}/${@}:$${version}; \
	docker push ${docker_repo_prefix}/${@}:$${version%.*}; \
	docker push ${docker_repo_prefix}/${@}:$${version%%.*}; \
	docker push ${docker_repo_prefix}/${@}:latest

flexget:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

gcloud:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

gimp:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

gitsome:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

hollywood:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

htop:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

keepass2:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

keepassxc:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

signal-messenger:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

signal-messenger-beta:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

spotifyd:
	@echo "==Building ${@}=="
	version=$$(curl -s https://api.github.com/repos/Spotifyd/spotifyd/releases/latest | grep "tag_name" | cut -d '"' -f 4 | sed 's/^v//'); \
	docker build -t ${docker_repo_prefix}/${@}:$${version} -t ${docker_repo_prefix}/${@}:$${version%.*} -t ${docker_repo_prefix}/${@}:$${version%%.*} -t ${docker_repo_prefix}/${@}:latest ${@}; \
	docker push ${docker_repo_prefix}/${@}:$${version}; \
	docker push ${docker_repo_prefix}/${@}:$${version%.*}; \
	docker push ${docker_repo_prefix}/${@}:$${version%%.*}; \
	docker push ${docker_repo_prefix}/${@}:latest

spotify-client:
	@echo "==Building ${@}=="
	docker build --no-cache -t ${docker_repo_prefix}/${@}:latest ${@}
	version=$$(docker run --rm ${docker_repo_prefix}/${@}:latest --version | cut -d ' ' -f 3 | cut -d '.' -f 1-4); \
	part_version=$${version%.*}; \
	docker build -t ${docker_repo_prefix}/${@}:$${version} -t ${docker_repo_prefix}/${@}:$${part_version} -t ${docker_repo_prefix}/${@}:$${part_version%.*} -t ${docker_repo_prefix}/${@}:$${part_version%%.*} -t ${docker_repo_prefix}/${@}:latest ${@}; \
	docker push ${docker_repo_prefix}/${@}:$${version}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version%.*}; \
	docker push ${docker_repo_prefix}/${@}:$${part_version%%.*}; \
	docker push ${docker_repo_prefix}/${@}:latest

vivaldi:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

vscode:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

vscodium:
	@echo "==Building ${@}=="
	version=$$(curl -s https://api.github.com/repos/VSCodium/vscodium/releases/latest | grep "tag_name" | cut -d '"' -f 4); \
	docker build -t ${docker_repo_prefix}/${@}:$${version} -t ${docker_repo_prefix}/${@}:$${version%.*} -t ${docker_repo_prefix}/${@}:$${version%%.*} -t ${docker_repo_prefix}/${@}:latest ${@}; \
	docker push ${docker_repo_prefix}/${@}:$${version}; \
	docker push ${docker_repo_prefix}/${@}:$${version%.*}; \
	docker push ${docker_repo_prefix}/${@}:$${version%%.*}; \
	docker push ${docker_repo_prefix}/${@}:latest
