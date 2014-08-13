DEBUG=0

build:
	docker build -t glenux/debian-repo .

run:
	ID=$$(docker run -v $$(pwd)/keys:/docker/keys -d -i -t glenux/debian-repo); \
	(docker inspect $$ID |sed -n -e 's/.*"IPAddress": "\(.*\)".*/\1/p'); \
	docker logs -f $$ID 

test:
	docker run -v $$(pwd)/keys:/docker/keys \
		--rm=true \
		-i -t glenux/debian-repo \
		/bin/bash

