#!/bin/sh

# Many thanks to John Fink <john.fink@gmail.com> for the 
# inspiration and to his great work on docker-wordpress' 

# reset root password

# let's create a user to SSH into
SSH_USERPASS=`pwgen -c -n -1 8`
mkdir /home/user
useradd -d /home/user -s /bin/bash user
chown -R user /home/user
chown -R user /docker/incoming
	
echo "user:$SSH_USERPASS" | chpasswd
echo "ssh user password: $SSH_USERPASS"

# pre-fill with SSH keys
echo "Pre-loading SSH keys from /docker/keys"
mkdir -p /home/user/.ssh
rm -f /home/user/.ssh/authorized_keys
for key in /docker/keys/*.pub ; do
	echo "- adding key $key"
	cat $key >> /home/user/.ssh/authorized_keys
done
chown -R user /home/user/.ssh

# load crontab for root
crontab <<EOF
* * * * * /usr/local/sbin/reprepro-import >> /var/log/reprepro.log
EOF

# run distro config generator
/usr/local/sbin/create-distros

# run import once, to create the right directory structure
/usr/local/sbin/reprepro-import

supervisord -n
