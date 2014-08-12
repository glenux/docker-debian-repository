FROM debian:testing
MAINTAINER Glenn Y. Rolland <glenux@glenux.net>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update


# Install supervisor for managing services
RUN apt-get install -q -y supervisor cron openssh-server pwgen reprepro screen vim-tiny

RUN service supervisor stop
ADD configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# Install cron for managing regular tasks
ADD configs/supervisor-cron.conf /etc/supervisor/conf.d/cron.conf
RUN sed -i 's/\(session *required *pam_loginuid.so\)/#\1/' /etc/pam.d/cron


# Install ssh
ADD configs/supervisor-ssh.conf /etc/supervisor/conf.d/ssh.conf
RUN mkdir /var/run/sshd

ENV DEBIAN_FRONTEND newt

ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

VOLUME /data
EXPOSE 80
EXPOSE 22
CMD ["/bin/bash", "/start.sh"]


