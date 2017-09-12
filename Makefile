NS ?= upme
VERSION ?= latest
NAME ?= app
ENVIRONMENT ?= development
IMAGE_NAME = $(NS)/$(NAME):$(VERSION)


run: build
	docker-compose run -e "RAILS_ENV="$(ENVIRONMENT) --service-ports --rm $(NAME)

build:
	docker build -t $(IMAGE_NAME) -f Dockerfile .

push: build
	docker push $(IMAGE_NAME)

shell: build
	docker run -it --rm $(IMAGE_NAME) /bin/sh

default: build

