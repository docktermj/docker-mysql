# Git variables

GIT_REPOSITORY_NAME := $(shell basename `git rev-parse --show-toplevel`)
GIT_VERSION := $(shell git describe --always --tags --long --dirty | sed -e 's/\-0//' -e 's/\-g.......//')

# Docker variables

DOCKER_IMAGE_TAG ?= $(GIT_REPOSITORY_NAME):$(GIT_VERSION)
DOCKER_CONTAINER_NAME ?= $(GIT_REPOSITORY_NAME)-$(GIT_VERSION)-container

# -----------------------------------------------------------------------------
# The first "make" target runs as default.
# -----------------------------------------------------------------------------

.PHONY: default
default: help

# -----------------------------------------------------------------------------
# Docker-based builds
# -----------------------------------------------------------------------------

.PHONY: docker-build
docker-build: docker-rmi
	docker build \
		--tag $(DOCKER_IMAGE_TAG) \
		.

.PHONY: docker-run
docker-run: docker-rm
	docker run -it \
	  --name $(DOCKER_CONTAINER_NAME) \
	  $(DOCKER_IMAGE_TAG)

# -----------------------------------------------------------------------------
# Utility targets
# -----------------------------------------------------------------------------

.PHONY: docker-rm
docker-rm:
	-docker rm $(DOCKER_CONTAINER_NAME)

.PHONY: docker-rmi
docker-rmi:
	-docker rmi --force $(DOCKER_IMAGE_TAG)

.PHONY: clean
clean: docker-rm docker-rmi

.PHONY: help
help:
	@echo "List of make targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
