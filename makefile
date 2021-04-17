docker_repo_prefix  := rjszynal
project_dockerfiles := $(wildcard */Dockerfile)
projects            := $(project_dockerfiles:%/Dockerfile=%)

github_build = @echo "==Building ${1}==" && \
	version=$$(curl -s https://api.github.com/repos/${1}/${1}/releases/latest | grep "tag_name" | cut -d '"' -f 4 | sed 's/^v//') && \
	part_version=$${version%.*} && \
	docker build -t ${docker_repo_prefix}/${1}:$${version} -t ${docker_repo_prefix}/${1}:$${part_version} -t ${docker_repo_prefix}/${1}:$${part_version%.*} -t ${docker_repo_prefix}/${1}:$${part_version%%.*} -t ${docker_repo_prefix}/${1}:latest ${1} && \
	docker push ${docker_repo_prefix}/${1}:$${version} && \
	docker push ${docker_repo_prefix}/${1}:$${part_version} && \
	docker push ${docker_repo_prefix}/${1}:$${part_version%.*} && \
	docker push ${docker_repo_prefix}/${1}:$${part_version%%.*} && \
	docker push ${docker_repo_prefix}/${1}:latest

suckless_build = @echo "==Building ${1}==" && \
	app="${1}" && \
	version=$$(curl -s https://git.suckless.org/$${app%%-*}/refs.html | grep '<tr>' | tail -n1 | sed -n 's/.*<td>\([0-9.]*\)<\/td>.*/\1/p') && \
	docker build -t ${docker_repo_prefix}/${1}:$${version} -t ${docker_repo_prefix}/${1}:$${version%.*} -t ${docker_repo_prefix}/${1}:$${version%%.*} -t ${docker_repo_prefix}/${1}:latest ${1} && \
	docker push ${docker_repo_prefix}/${1}:$${version} && \
	docker push ${docker_repo_prefix}/${1}:$${version%.*} && \
	docker push ${docker_repo_prefix}/${1}:$${version%%.*} && \
	docker push ${docker_repo_prefix}/${1}:latest

foldingathome_build = @echo "==Building ${1}==" && \
	version=$$(curl -s https://download.foldingathome.org/ | grep "fahclient/debian-stable-64bit" | grep -Po '\d.\d.\d') && \
	docker build --build-arg fah_version=$${version} -t ${docker_repo_prefix}/${1}:$${version} -t ${docker_repo_prefix}/${1}:$${version%.*} -t ${docker_repo_prefix}/${1}:$${version%%.*} -t ${docker_repo_prefix}/${1}:latest ${1} && \
	docker push ${docker_repo_prefix}/${1}:$${version} && \
	docker push ${docker_repo_prefix}/${1}:$${version%.*} && \
	docker push ${docker_repo_prefix}/${1}:$${version%%.*} && \
	docker push ${docker_repo_prefix}/${1}:latest

version_build = @echo "==Building ${1}==" && \
	docker build --no-cache -t ${docker_repo_prefix}/${1}:latest ${1} && \
	version=$$(docker run --rm ${docker_repo_prefix}/${1}:latest --version | perl -lpe '($$_)=/([0-9]+([.][0-9]+)+)/' | cut -d '.' -f 1-4 | head -n1) && \
	part_version=$${version%.*} && \
	docker build -t ${docker_repo_prefix}/${1}:$${version} -t ${docker_repo_prefix}/${1}:$${part_version} -t ${docker_repo_prefix}/${1}:$${part_version%.*} -t ${docker_repo_prefix}/${1}:$${part_version%%.*} -t ${docker_repo_prefix}/${1}:latest ${1} && \
	docker push ${docker_repo_prefix}/${1}:$${version} && \
	docker push ${docker_repo_prefix}/${1}:$${part_version} && \
	docker push ${docker_repo_prefix}/${1}:$${part_version%.*} && \
	docker push ${docker_repo_prefix}/${1}:$${part_version%%.*} && \
	docker push ${docker_repo_prefix}/${1}:latest


.PHONY: all alpine debian audacity awscli azure-cli chrome chrome-beta chromium firefox flexget foldingathome gcloud gimp gitsome hollywood htop keepass2 keepassxc signal-messenger signal-messenger-beta spotify-client spotifyd st st-monokai surf vivaldi vscode vscodium

all: ${projects}

alpine: azure-cli flexget gcloud gitsome keepassxc

debian: audacity awscli chrome chrome-beta chromium firefox gimp hollywood htop keepass2 signal-messenger signal-messenger-beta spotifyd spotify-client vivaldi vscode vscodium

ubuntu: foldingathome

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
	$(call version_build,${@})

chrome-beta:
	$(call version_build,${@})

chromium:
	$(call version_build,${@})

firefox:
	$(call version_build,${@})

flexget:
	$(call version_build,${@})

foldingathome:
	$(call foldingathome_build,${@})

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

spotify-client:
	$(call version_build,${@})

spotifyd:
	$(call github_build,${@})

st:
	$(call suckless_build,${@})

st-monokai:
	$(call suckless_build,${@})

surf:
	$(call suckless_build,${@})

vivaldi:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

vscode:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

vscodium:
	$(call github_build,${@})
