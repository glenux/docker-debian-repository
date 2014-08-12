
build:
	docker build -t glenux/debian-repo .

run:
	docker run -i -t glenux/debian-repo /bin/bash

