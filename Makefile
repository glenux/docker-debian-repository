DEBUG=0

ifeq ($(DEBUG),0)
RUNCMD=
else
RUNCMD=-i /bin/bash
endif

build:
	docker build -t glenux/debian-repo .

run:
	ID=$$(docker run -v $$(pwd)/keys:/docker/keys -d -t glenux/debian-repo $(RUNCMD)); \
	(docker inspect $$ID |sed -n -e 's/.*"IPAddress": "\(.*\)".*/\1/p'); \
	docker logs -f $$ID 

