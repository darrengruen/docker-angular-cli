GIT_SHA = $$(git rev-parse --short HEAD)
BUILD_DATE = $$(date -u +%G_%T_%Z)
REPOSITORY = gruen
IMAGE = angular-cli
TAG = $$(git rev-parse --abbrev-ref HEAD || "dev")
FILTER = "label=org.label-schema.name=angular-cli"
RUN_NAME = $(IMAGE)_RUN

build: .build ## Builds the image (Default)

clean: .clean ## Cleans up images and containers

help: .help ## Outputs this help

install: .install ## Instructions on "installing"

run: .run ## Run the container. Useful for pretty much testing only

.build:
	@docker build \
	    --build-arg BUILD_DATE=$(BUILD_DATE) \
	    --build-arg GIT_SHA=$(GIT_SHA) \
	    -t $(REPOSITORY)/$(IMAGE):$(TAG) \
	    .

.clean: 
    ifneq ($(shell docker ps -a -f $(FILTER) --format "{{.Names}}"),)
	@docker rm -f $$(docker ps -a filter $(FILTER) --format "{{.Names}}")
    endif
    ifneq ($(shell docker images -f $(FILTER) --format "{{.ID}}"),)
	@docker rmi $$(docker images -f $(FILTER) --format "{{.ID}}")
    endif

.help: ## Outputs this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "- \033[36m%-20s\033[0m %s\n", $$1, $$2}' ${MAKEFILE_LIST}

.install:
	@printf "%s\n" \
	    "The easiest thing to do is add something like the following to your profile or path:" \
	    "    docker run -it --rm"  \
	    "        -v ${PWD}:/workdir" \
	    "        -w /workdir" \
	    "        --name angular-cli" \
	    "        $(REPOSITORY)/$(IMAGE)[:optional tag]"

.run:
	docker run -it --rm \
	    -v "${PWD}":/workdir \
	    -w /workdir \
	    --name $(RUN_NAME) \
	    --user "$$(id -u):$$(id -g)" \
	    $(REPOSITORY)/$(IMAGE):$(TAG)
    
.PHONY: build help
