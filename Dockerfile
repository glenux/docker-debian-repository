FROM debian:testing
MAINTAINER Glenn Y. Rolland <glenux@glenux.net>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update


# Install supervisor for managing services
RUN apt-get install -q -y supervisor cron openssh-server pwgen reprepro screen vim-tiny nginx


# Configure cron
# Install cron for managing regular tasks
RUN sed -i 's/\(session *required *pam_loginuid.so\)/#\1/' /etc/pam.d/cron


# Install ssh (run/stop to create required directories)
RUN mkdir /var/run/sshd
#RUN service ssh start ; sleep 1
RUN service ssh stop


# Configure reprepro
ADD scripts/reprepro-import.sh /usr/local/sbin/reprepro-import
RUN chmod 755 /usr/local/sbin/reprepro-import
RUN mkdir -p /var/lib/reprepro/conf
ADD configs/reprepro-distributions /var/lib/reprepro/conf/distributions

# Configure nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm -f /etc/nginx/sites-enabled/default
ADD configs/nginx-default.conf /etc/nginx/sites-enabled/default

# Setup root access
RUN echo "root:docker" | chpasswd

# Configure supervisor
RUN service supervisor stop
ADD configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD configs/supervisor-cron.conf /etc/supervisor/conf.d/cron.conf
ADD configs/supervisor-ssh.conf /etc/supervisor/conf.d/ssh.conf
ADD configs/supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf

# Finalize
ENV DEBIAN_FRONTEND newt

ADD scripts/start.sh /usr/local/sbin/start
RUN chmod 755 /usr/local/sbin/start

VOLUME ["/docker/keys", "/docker/incoming", "/repository"]

EXPOSE 80
EXPOSE 22
CMD ["/usr/local/sbin/start"]
