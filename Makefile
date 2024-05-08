IMAGE_NAME = iac
CONTAINER_NAME = iac-container
DIRECTORY = .

.PHONY: build run shell clean restart

build:
	@docker build -t $(IMAGE_NAME) $(DIRECTORY)

run:
	@docker run -d --name $(CONTAINER_NAME) -v $(DIRECTORY):/workspace $(IMAGE_NAME)

shell:
	@docker exec -it $(CONTAINER_NAME) /bin/bash

clean:
	@docker stop $(CONTAINER_NAME)
	@docker rm $(CONTAINER_NAME)
	@docker rmi $(IMAGE_NAME)
	
restart: clean build run