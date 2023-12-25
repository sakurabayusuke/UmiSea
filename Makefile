.PHONY: run-container remove-all-container

run-container:
	docker run -it -v ./lambda/repository:/usr/src/app/repository lambda-function:1.0 bash
remove-all-container:
	docker ps -aq | xargs docker rm
