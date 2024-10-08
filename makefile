docker_repo_prefix  := rjszynal
project_dockerfiles := $(wildcard */Dockerfile)
projects            := $(project_dockerfiles:%/Dockerfile=%)

github_build = @echo "==Building ${2}==" && \
	version=$$(curl -s https://api.github.com/repos/${1}/${2}/releases/latest | grep "tag_name" | cut -d '"' -f 4 | sed 's/^v//') && \
	part_version=$${version%.*} && \
	if [ $$(docker manifest inspect ${docker_repo_prefix}/${2}:$${version} > /dev/null ; echo $$?) -gt 0 ]; then \
		docker build --build-arg version=$${version} -t ${docker_repo_prefix}/${2}:$${version} -t ${docker_repo_prefix}/${2}:$${part_version} -t ${docker_repo_prefix}/${2}:$${part_version%.*} -t ${docker_repo_prefix}/${2}:$${part_version%%.*} -t ${docker_repo_prefix}/${2}:latest ${2} && \
		docker push ${docker_repo_prefix}/${2}:$${version} && \
		docker push ${docker_repo_prefix}/${2}:$${part_version} && \
		docker push ${docker_repo_prefix}/${2}:$${part_version%.*} && \
		docker push ${docker_repo_prefix}/${2}:$${part_version%%.*} && \
		docker push ${docker_repo_prefix}/${2}:latest; \
	else \
		echo "Latest version already built"; \
	fi

suckless_build = @echo "==Building ${1}==" && \
	app="${1}" && \
	version=$$(curl -s https://git.suckless.org/$${app%%-*}/refs.html | sed -n 's/.*<td>\([0-9.]*\)<\/td>.*/\1/p' | sed -n '2p') && \
	if [ $$(docker manifest inspect ${docker_repo_prefix}/${1}:$${version} > /dev/null ; echo $$?) -gt 0 ]; then \
		docker build -t ${docker_repo_prefix}/${1}:$${version} -t ${docker_repo_prefix}/${1}:$${version%.*} -t ${docker_repo_prefix}/${1}:$${version%%.*} -t ${docker_repo_prefix}/${1}:latest ${1} && \
		docker push ${docker_repo_prefix}/${1}:$${version} && \
		docker push ${docker_repo_prefix}/${1}:$${version%.*} && \
		docker push ${docker_repo_prefix}/${1}:$${version%%.*} && \
		docker push ${docker_repo_prefix}/${1}:latest; \
	else \
		echo "Latest version already built"; \
	fi

foldingathome_build = @echo "==Building ${1}==" && \
	version=$$(curl -s https://download.foldingathome.org/ | jq -r '.[] | select(.platform=="lin") | .groups[] | select(.oses[]=="Debian") | .files[] | select(.filename | contains("amd64")) | .version | join(".")') && \
	if [ $$(docker manifest inspect ${docker_repo_prefix}/${1}:$${version} > /dev/null ; echo $$?) -gt 0 ]; then \
		docker build --build-arg fah_version=$${version} -t ${docker_repo_prefix}/${1}:$${version} -t ${docker_repo_prefix}/${1}:$${version%.*} -t ${docker_repo_prefix}/${1}:$${version%%.*} -t ${docker_repo_prefix}/${1}:latest ${1} && \
		docker push ${docker_repo_prefix}/${1}:$${version} && \
		docker push ${docker_repo_prefix}/${1}:$${version%.*} && \
		docker push ${docker_repo_prefix}/${1}:$${version%%.*} && \
		docker push ${docker_repo_prefix}/${1}:latest; \
	else \
		echo "Latest version already built"; \
	fi

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


.PHONY: all alpine debian audacity awscli azure-cli chrome chrome-beta chromium firefox flexget foldingathome gcloud gimp gitsome hollywood htop hostess keepass2 keepassxc signal-messenger signal-messenger-beta spotify-client spotifyd st st-monokai surf vivaldi vscode vscodium

all: ${projects}

alpine: azure-cli gcloud gitsome keepassxc

debian: audacity awscli chrome chrome-beta chromium firefox flexget gimp hollywood htop hostess keepass2 signal-messenger signal-messenger-beta spotifyd spotify-client st st-monokai surf vivaldi vscode vscodium

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

hostess:
	$(call github_build,cbednarski,${@})

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
	$(call github_build,${@},${@})

st:
	$(call suckless_build,${@})

st-monokai:
	$(call suckless_build,${@})

surf:
	$(call suckless_build,${@})

vivaldi:
	$(call version_build,${@})

vscode:
	@echo "==Building ${@}=="
	@echo "This is currently a manual build"

vscodium:
	$(call github_build,${@},${@})
