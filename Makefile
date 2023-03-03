APP=headers
VERSION=0.0.2
HOSTNAME=headers.local

build:  ## Build Docker Image
	@echo "Building Application ${APP}:${VERSION}"
	docker build -t ${APP}:${VERSION} .

deploy: ## Helm Deploy docker image
	@echo Helm Deploying
	helm upgrade headers ./headerschart

test:   ### curl test egress endpoint
	curl --connect-timeout 2 -H 'Host: ${HOSTNAME}' http://$(shell minikube ip):80

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
