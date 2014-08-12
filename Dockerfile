FROM debian:testing
MAINTAINER Glenn Y. Rolland <glenux@glenux.net>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -q -y supervisor
RUN apt-get install -q -y reprepro

ENV DEBIAN_FRONTEND newt
VOLUME /data

ADD scripts/start.sh /start.sh

EXPOSE 80
EXPOSE 22
CMD ["/bin/bash", "/start.sh"]


