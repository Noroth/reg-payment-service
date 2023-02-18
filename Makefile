# On Windows OS is set. This makefile requires Linux or MacOS
ifeq ($(OS),)
#SHELL := /bin/ash
MAKE ?= make

BUILD_TARGETS += init-ci
BUILD_TARGETS += deps
BUILD_TARGETS += test

VERSION ?= v0.0.0

checktool = $(shell command -v $1 2>/dev/null)
tool = $(if $(call checktool, $(firstword $1)), $1, @echo "$(firstword $1) was not found on the system. Please install it")

GO ?= $(call checktool, go)
GOTEST ?= $(GO) test
GOTEST_ARGS ?= -timeout 2m -count 1 -cover

GOBUILD ?= $(GO) build
GOBUILD_ARGS ?= -ldflags "-s -w" -trimpath

GOLANGCI_LINT ?= $(call tool,golangci-lint)
DOCKER_COMPOSE ?= $(call tool, docker-compose)

DOCKER_BUILDX_NAME=ci_builder

.PHONY: init-ci
init-ci: 
	git config --global url.git@github.com:.insteadOf https://github.com/

ifeq ($(DOCKER_BUILD), true)

.PHONY: deps
deps:
	$(GO) mod download
	$(GO) mod verify
else
.PHONY: deps
deps:
	$(GO) mod download
endif


.PHONY: test
test:
	@$(GO) clean -testcache
	$(GOTEST) $(GOTEST_ARGS) ./... -v

.PHONY: lint
lint:
	@$(GOLANGCI_LINT) run ./...

.PHONY: build
build: $(BUILD_TARGETS)
	@CGO_ENABLED=0 $(GOBUILD) $(GOBUILD_ARGS) -o ./service cmd/main.go

.PHONY: up
up:
	@$(DOCKER_COMPOSE) up -d --build

.PHONY: down
down:
	@$(DOCKER_COMPOSE) down


.PHONY: docker-init-multiarch
docker-init-multiarch:
	(docker buildx use $(DOCKER_BUILDX_NAME) &> /dev/null  && echo "using existing builder instance $(DOCKER_BUILDX_NAME)") \
		|| (echo "creating new instance $(DOCKER_BUILDX_NAME)" && docker buildx create --name $(DOCKER_BUILDX_NAME) --use --bootstrap)

.PHONY: docker-build-multiarch
docker-build-multiarch: docker-init-multiarch
# TODO

.PHONY: build-docker
build-docker: .ssh docker-build-multiarch

endif